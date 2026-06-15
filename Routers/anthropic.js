import express from 'express';
import { ChatAnthropic } from "@langchain/anthropic";

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

router.post('/chat', async (req, res) => {
    const { message } = req.body;

    if (!message) {
        return res.status(400).json({ error: 'Il messaggio è obbligatorio' });
    }

    try {
        console.log(`--- Invio richiesta a Claude (${model.modelName || 'default'}) ---`);
        const response = await model.invoke(message);

        res.json({ reply: response.content });
        console.log("--- Risposta ricevuta con successo ---");
    } catch (error) {
        console.error('ERRORE DETTAGLIATO:', error);
        res.status(500).json({ error: error.message || 'Errore nella generazione della risposta' });
    }
});

export default router;