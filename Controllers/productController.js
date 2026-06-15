import { connection } from '../Utils/connection.js';
import { normalizingProducts } from '../Utils/function.js';
import { stringCheck } from '../Utils/function.js';
import { queryProduct, queryProductCategory, queryProductLimit, queryProductSearch, queryProductShow, queryProductCategoryAndSearch } from '../Utils/query.js';


export const index = async (request, response) => {
    const { latest, search } = request.query || {};
    
    const slug = request.categorySlug; // Validato dal middleware
    const latestNumber = latest ? parseInt(latest, 10) : null;
    const searchedString = stringCheck(search) ? search : null; // Funzione di controllo stringa

    let productsList = null;

    try {
        // CASO 1: Presenti SIA Categoria (valida) SIA Ricerca Testuale
        if (slug && searchedString) {
            const searchParam = `%${searchedString}%`;
            const [rows] = await connection.execute(queryProductCategoryAndSearch, [slug, searchParam, searchParam]);
            
            if (rows.length === 0) {
                return response.json({
                    error: 'La ricerca all\'interno di questa categoria non ha prodotto risultati',
                    result: null
                });
            }
            productsList = normalizingProducts(rows);
        }
        
        // CASO 2: Presente SOLO la Categoria (valida)
        else if (slug) {
            const [rows] = await connection.execute(queryProductCategory, [slug]);
            
            if (rows.length === 0) {
                return response.json({
                    error: 'La ricerca per categoria non ha prodotto risultati',
                    result: null
                });
            }
            productsList = normalizingProducts(rows);
        }
        
        // CASO 3: Presente SOLO la Ricerca Testuale
        else if (searchedString) {
            const searchParam = `%${searchedString}%`;
            const [rows] = await connection.execute(queryProductSearch, [searchParam, searchParam]);
            
            if (rows.length === 0) {
                return response.json({
                    error: 'La ricerca testuale non ha prodotto risultati',
                    result: null
                });
            }
            productsList = normalizingProducts(rows);
        }
        
        // CASO 4: Richiesta degli ultimi "N" prodotti (senza filtri di ricerca)
        else if (latestNumber && !isNaN(latestNumber) && latestNumber > 0) {
            const [rows] = await connection.query(queryProductLimit, [latestNumber]);
            productsList = normalizingProducts(rows);
        }
        
        // CASO 5: Nessun parametro fornito (Ritorna tutti i prodotti)
        else {
            const [rows] = await connection.execute(queryProduct);
            productsList = normalizingProducts(rows);
        }

        // Risposta unica di successo per tutti i casi che hanno trovato prodotti
        return response.json({
            error: null,
            result: productsList
        });

    } catch (error) {
        console.error(error);
        return response.status(500).json({
            error: "Errore nella connessione al database",
            result: null
        });
    }
};

export const show = async (request, response) => {
    const id = request.validatedId;
    try {
        const [rows] = await connection.execute(queryProductShow, [id]);
        if (rows.length === 0) {
            return response
                .json({
                    error: 'Prodotto non trovato',
                    result: null
                });
        }
        const searchedProduct = normalizingProducts(rows);
        console.log(searchedProduct)
        response
            .json({
                error: null,
                result: searchedProduct
            });
    } catch (error) {
        
        response
            .status(500)
            .json({
                error: "errore nella connessione",
                result: null
            });
    }
};

