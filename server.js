import express from 'express'
import notFound from './Middlewears/notFound.js';
import errorsHandler from './Middlewears/errorsHandler.js';
import recensioni from './Routers/recensioni.js';
import categorie from './Routers/categorie.js'
import products from './Routers/products.js';
import anthropic from './Routers/anthropic.js';
import cors from 'cors';

const SERVER_PORT = process.env.SERVER_PORT || 3000;
const SERVER_URL = process.env.SERVER_URL || 'http://localhost';


const app = express();
app.use(cors());
app.use(express.static('data'))
app.use(express.json());
app.use('/categories', categorie);
app.use('/reviews', recensioni);
app.use('/products', products);
app.use('/anthropic', anthropic);



app.use(errorsHandler);
app.use(notFound);

app.listen(SERVER_PORT, () => {
    console.log(`🚀 Il server è avviato sulla porta ${SERVER_PORT}`);
});