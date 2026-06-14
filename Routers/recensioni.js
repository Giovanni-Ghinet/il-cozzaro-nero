import express, { request, response } from 'express'
import idValidator from '../Middlewears/idValidator.js';
import { show, index, store, destroy } from '../Controllers/recensioniControllers.js';
import bodyValidator from '../Middlewears/bodyValidator.js';



const recensioni = express.Router();



recensioni.get('/', index);
recensioni.get('/:id', idValidator, show);
recensioni.post('/', bodyValidator, store);
//recensioni.put('/:id', idValidator, update);
recensioni.delete('/:id', idValidator, destroy);






export default recensioni