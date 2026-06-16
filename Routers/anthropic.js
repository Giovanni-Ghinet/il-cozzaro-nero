import express from 'express';
import { ChatAnthropic } from "@langchain/anthropic";
import { connection } from '../Utils/connection.js';
import { HumanMessage, SystemMessage, ToolMessage } from "@langchain/core/messages";
import { queryProduct } from '../Utils/query.js';
import { normalizingProducts } from '../Utils/function.js';
import { z } from "zod";

const router = express.Router();

// Debug per verificare se la chiave viene letta (non stamparla intera per sicurezza)
if (!process.env.ANTHROPIC_API_KEY) {
    console.error("❌ ERRORE: ANTHROPIC_API_KEY non trovata in process.env");
}

const model = new ChatAnthropic({
    modelName: "claude-sonnet-4-6",
    max_tokens: 1024,
    anthropicApiKey: process.env.ANTHROPIC_API_KEY,
});

// Definizione dello strumento per inserire recensioni
const createReviewTool = {
    name: "create_review",
    description: "Inserisce una nuova recensione per un prodotto nel database.",
    schema: z.object({
        productName: z.string().describe("Il nome esatto del prodotto da recensire"),
        author: z.string().describe("Nome di chi scrive la recensione"),
        title: z.string().describe("Titolo della recensione"),
        text: z.string().describe("Contenuto della recensione"),
        valutation: z.number().min(0).max(5).describe("Voto da 0 a 5")
    })
};

const modelWithTools = model.bindTools([createReviewTool]);

router.post('/chat', async (req, res) => {
    const { message } = req.body;

    if (!message) {
        return res.status(400).json({ error: 'Il messaggio è obbligatorio' });
    }

    try {
        // 1. Recupero dati dal Database per dare contesto all'IA
        // Utilizziamo la query definita in query.js che unisce prodotti, categorie e recensioni
        const [rows] = await connection.execute(queryProduct);
        const [categories] = await connection.execute('SELECT name FROM categories');

        // Utilizziamo la funzione di normalizzazione per raggruppare i dati (recensioni incluse)
        const productsList = normalizingProducts(rows);

        // 2. Costruiamo una stringa di contesto con i dati reali
        const menuContext = productsList.map(p => {
            // Calcoliamo la valutazione media per ogni prodotto
            const avgRating = p.reviews.length > 0
                ? (p.reviews.reduce((acc, r) => acc + parseFloat(r.valutation), 0) / p.reviews.length).toFixed(1)
                : "Nessuna";
            return `- ${p.name} [Categoria: ${p.category}] (${p.country}): ${p.description}. Prezzo: ${p.price}€. Disponibilità: ${p.availability ? 'Disponibile' : 'Esaurito'}. Valutazione Media: ${avgRating}/5 (${p.reviews.length} recensioni).`;
        }).join('\n');

        const categoriesContext = categories.map(c => c.name).join(', ');

        // 3. Definiamo il System Message per istruire Claude sulla sua identità e sui dati
        const systemPrompt = new SystemMessage(
            `Sei l'assistente virtuale ufficiale del ristorante "Il Cozzaro Nero". 
            Il tuo compito è aiutare i clienti con informazioni precise basate esclusivamente sui dati forniti.
            
            DATI DEL RISTORANTE:
            - Categorie: ${categoriesContext}
            - Menu attuale:
            ${menuContext}

            REGOLE DI RISPOSTA:
            1. Usa un tono piratesco, amichevole e professionale.
            2. Se un prodotto è "Esaurito", avvisa il cliente che non è al momento ordinabile.
            3. GESTIONE RECENSIONI: Se un utente vuole lasciare una recensione, chiedi esplicitamente: Nome del Piatto, Nome Autore, Titolo, Testo e Voto (0-5). 
            4. Solo quando hai TUTTI i dati, usa lo strumento 'create_review'.
            5. Se non conosci la risposta, scusati e suggerisci di contattare il capitano.`
        );

        console.log(`--- Invio richiesta a Claude (${model.modelName || 'default'}) ---`);
        
        let response = await modelWithTools.invoke([systemPrompt, new HumanMessage(message)]);

        // 4. Se l'IA vuole chiamare il tool per pubblicare la recensione
        if (response.tool_calls && response.tool_calls.length > 0) {
            const toolCall = response.tool_calls[0];
            
            if (toolCall.name === "create_review") {
                const { productName, author, title, text, valutation } = toolCall.args;

                // Recuperiamo l'ID del prodotto dal nome
                const [pRows] = await connection.execute('SELECT id FROM products WHERE name = ?', [productName]);
                
                if (pRows.length > 0) {
                    const id_product = pRows[0].id;
                    // Inserimento nel database
                    await connection.execute(
                        'INSERT INTO reviews (valutation, text, id_product, author, title) VALUES (?, ?, ?, ?, ?)',
                        [valutation, text, id_product, author, title]
                    );

                    // Conferma all'IA che l'operazione è riuscita per generare la risposta finale
                    const toolMessage = new ToolMessage({
                        content: "Recensione pubblicata con successo nel registro di bordo!",
                        tool_call_id: toolCall.id
                    });

                    const finalResponse = await modelWithTools.invoke([
                        systemPrompt,
                        new HumanMessage(message),
                        response,
                        toolMessage
                    ]);
                    
                    console.log("--- Recensione salvata e risposta inviata ---");
                    return res.json({ reply: finalResponse.content });
                } else {
                    return res.json({ reply: `Corbezzoli! Non trovo nessun piatto chiamato "${productName}" nel mio diario di bordo.` });
                }
            }
        }

        res.json({ reply: response.content });
        console.log("--- Risposta ricevuta con successo ---");
    } catch (error) {
        console.error('ERRORE DETTAGLIATO:', error);
        res.status(500).json({ error: error.message || 'Errore nella generazione della risposta' });
    }
});

export default router;
