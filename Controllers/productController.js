import { connection } from '../Utils/connection.js';
import { normalizingProducts } from '../Utils/function.js';
import { stringCheck } from '../Utils/function.js';
import { queryProduct, queryProductCategory, queryProductLimit, queryProductSearch, queryProductShow } from '../Utils/query.js';


export const index = async (request, response) => {
    const { latest, search } = request.query || {};
    const slug = request.categorySlug;
    const latestNumber = stringCheck(latest) ? Number(latest) : null;
    const searchedString = stringCheck(search) ? search : null;

    let productsList = null;
    try {
        if (slug){
            const [rows] = await connection.execute(queryProductCategory,[slug]);
            if (rows.length === 0){
                return response
                        .status(404)
                        .json({
                            error: 'La ricerca per categoria non ha prodotto risultati',
                            result: null
                        });
            }
            productsList = normalizingProducts(rows);
            return response
                .json({
                    error: null,
                    result: productsList
                });
            
        }




        if (!Number.isNaN(latestNumber) && latestNumber !== null) {
            const [rows] = await connection.execute(queryProductLimit, [latestNumber]);
            productsList = normalizingProducts(rows);
        } else if (searchedString !== null) {
            const searchParam = `%${searchedString}%`;
            const [rows] = await connection.execute(queryProductSearch, [searchParam, searchParam]);
            if (rows.length === 0) {
                return response
                    .status(404)
                    .json({
                        error: 'La ricerca non ha prodotto risultati',
                        result: null
                    });
            }
            productsList = normalizingProducts(rows);
        } else {
            const [rows] = await connection.execute(queryProduct);
            productsList = normalizingProducts(rows);
        }
        response
            .json({
                error: null,
                result: productsList
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

export const show = async (request, response) => {
    const id = request.validatedId;
    try {
        const [rows] = await connection.execute(queryProductShow, [id]);
        if (rows.length === 0) {
            return response
                .status(404)
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

