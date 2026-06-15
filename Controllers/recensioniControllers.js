import { connection } from "../Utils/connection.js";
import { reviewsNormalizer } from "../Utils/function.js";





/*
INDEX
*/
async function index(request, response) {
    try {
        const sql = `
            SELECT r.id, r.title, r.valutation, r.text, r.author, p.name AS product_name, r.created_at as date
            FROM reviews r
            JOIN products p 
                ON r.id_product = p.id
            order by date desc;`;

        const [results] = await connection.query(sql);

        const resultsNormalized = results.map(review => (reviewsNormalizer(review)));

        response.status(200).json({
            error: null,
            result: resultsNormalized
        });
    } catch (error) {
        console.error(error);

        response.status(500).json({
            error: "Errore interno del server",
            result: null
        });
    }
}

/*
SHOW
*/
async function show(request, response) {
    try {
        const id = request.validatedId;

        const sql = `
            SELECT r.id, r.title, r.valutation, r.text, r.author, p.name AS product_name
            FROM reviews r
            JOIN products p 
                ON r.id_product = p.id
            WHERE r.id = ?;`

        const [results] = await connection.execute(sql, [id]);

        if (results.length === 0) {
            return response.status(404).json({
                error: "Recensione non trovata",
                result: null
            });
        }

        response.status(200).json({
            error: null,
            result: results[0]
        });
    } catch (error) {
        console.error(error);

        response.status(500).json({
            error: "Errore interno del server",
            result: null
        });
    }
}


/*
CREATE
*/
async function store(request, response) {


    try {
        const newReviews = { ...request.body };
        const { product } = newReviews;
        const querySearchProduct =
            `select p.id
        from products p
        where p.name = ?;`;

        const [productId] = await connection.execute(querySearchProduct, [product]);
        if (productId.length === 0) {
            response
                .status(404)
                .json({
                    error: "il prodotto non esiste"
                });
            return
        }

        const reviews = { ...newReviews, product: productId[0].id };
        const queryInsertReviews = `
        INSERT INTO reviews (valutation, text, id_product, author, title) VALUES
            (?, ?, ?, ?, ?);
        `;
        const { valutation, text, product: id_product, author, title } = reviews;
        const [result] = await connection.execute(queryInsertReviews, [valutation, text, id_product, author, title]);
        if (result.affectedRows > 0) {
            response
                .json({
                    error: null,
                    result: "Recensione inserita con successo"
                });
            return
        } else {
            response
                .status(400)
                .json({
                    error: "richiesta errata",
                    result: null
                })
        }
    } catch (error) {
        response
            .status(500)
            .json({
                error: "errore durante l'inserimento al database",
                result: null
            });
    }
}


/*
DESTROY
*/
async function destroy(request, response) {
    try {

        const id = request.validatedId;

        const sql = "DELETE FROM reviews WHERE id = ?";

        const [result] = await connection.execute(sql, [id]);
        if (result.affectedRows > 0) {
            response
                .status(204)
                .json({
                    error: null,
                    message: "Recensione eliminata"
                });
        } else {
            response
                .status(400)
                .json({
                    error: "richiesta errata",
                    result: null
                })
        }
    } catch (error) {
        response
            .status(500)
            .json({
                error: "errore durante l'eliminazione del dato dal database",
                result: null
            });
    }
}


export { destroy, index, show, store };