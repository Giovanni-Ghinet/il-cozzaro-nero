

const defaultOBJReceived = {
    title: "",
    text: "",
    author: "",
    valutation: null,
    product: ""
};




export const idCheck = (id) => {
    return typeof id === "number" && !Number.isNaN(id) && id > 0;
}


const keyValidator = (obj) => {
    const chiaviDefaultOBJ = Object.keys(defaultOBJReceived);
    const chiaviObj = Object.keys(obj);

    if (chiaviObj.length !== chiaviDefaultOBJ.length) {
        return false
    }
    return chiaviDefaultOBJ.every(chiave => obj.hasOwnProperty(chiave));
}

const valueValidator = (obj) => {
    const { title, text, author, valutation, product } = obj;

    if (typeof title !== 'string' || title.trim() === '' || title.length > 200) return false;
    if (typeof text !== 'string' || text.trim() === '') return false;
    if (typeof author !== 'string' || author.trim() === '' || author.length > 200) return false;
    if (typeof product !== 'string' || product.trim() === '' || product.length > 200) return false;
    if (typeof valutation !== 'number' || valutation < 0 || valutation > 5 || Number.isNaN(latest)) return false;

    return true;
}

export const validator = (obj) => {
    if (!keyValidator(obj)) return false;
    return valueValidator(obj);
}




export function normalizingProducts(dataArray) {
    const productsMap = {};
    const IMAGE_PREFIX = "http://localhost:3000/";

    for (const product of dataArray) {

        const { id_review, author, title, text, latest, image, price, created_at, valutation, ...productData } = product;
        const productName = product.name;
        const priceConverted = Number(price);

        if (!productsMap[productName]) {
            const formattedDate = created_at ? new Date(created_at).toLocaleDateString('it-IT') : null;
            productsMap[productName] = {
                ...productData,
                created_at: formattedDate,
                price: priceConverted,
                image: image ? `${IMAGE_PREFIX}${image}` : "https://placehold.co/600x400/png",
                reviews: []
            };
        }

        if (id_review !== undefined && id_review !== null) {
            const review = { id_review, author, title, text, latest, valutation };
            productsMap[productName].reviews.push(review);
        }
    }

    return Object.values(productsMap);
}


export function stringCheck(string) {
    return typeof string === 'string' && string.trim() !== '';
}



export async function generateUniqueCategorySlug(name, dbConnection) {
    let baseSlug = name
        .toLowerCase()
        .normalize("NFD") //normalizza le lettere con accento
        .replace(/[\u0300-\u036f]/g, "") // rimuove il carattere degli accenti isolati
        .replace(/['\s]+/g, "-") //sostituisce gli spazi con un trattino
        .replace(/[^a-z0-9-]+/g, "") //rimuove tutto ció che non é lettera numero o trattino
        .replace(/-+/g, "-") // sostituisce i trattini multipli con uno solo
        .replace(/^-+|-+$/g, ""); //rimuove i trattini ad inizio e fine stringa

    let currentSlug = baseSlug;
    let counter = 1;
    let isUnique = false;

    while (!isUnique) {
        const [rows] = await dbConnection.execute(
            'SELECT id FROM categories WHERE slug = ? LIMIT 1', 
            [currentSlug]
        );

        if (rows.length === 0) {
            isUnique = true;
        } else {
            currentSlug = `${baseSlug}-${counter}`;
            counter++;
        }
    }

    return currentSlug;
}


export function reviewsNormalizer(recensione) {

    const votoNumero = parseFloat(recensione.valutation);
    const formattedDate = recensione.date ? new Date(recensione.date).toLocaleDateString('it-IT') : null;

    return {
        ...recensione,
        valutation: votoNumero,
        date: formattedDate
    };
}