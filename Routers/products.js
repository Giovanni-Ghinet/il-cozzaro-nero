import express from 'express';
import idValidator from '../Middlewears/idValidator.js';
import {index} from '../Controllers/productController.js';
import {show} from '../Controllers/productController.js'; 
import categoryCheck from '../Middlewears/categoryCheck.js';

const app = express();

app.get('/', categoryCheck,index);
app.get('/:id', idValidator, show);

export default app;

