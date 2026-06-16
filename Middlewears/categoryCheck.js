import { connection } from "../Utils/connection.js";


async function categoryCheck(request, response, next) {
    try {
        const { slug } = request.query;


        if (!slug) {
            request.categorySlug = null;
            return next();
        }


        const [rows] = await connection.execute(
            `SELECT slug 
            FROM categories
            WHERE slug = ? 
            LIMIT 1`,
            [slug]
        );




        if (rows.length === 0) {
            return response.status(404).json({
                error: "La categoria specificata non esiste",
                result: null
            });
        } else {
            request.categorySlug = rows[0].slug;
        }


        next();

    } catch (error) {
        response
            .status(500)
            .json({
                error: "Errore interno del server durante il controllo categoria",
                result: null
            });
    }
};

export default categoryCheck