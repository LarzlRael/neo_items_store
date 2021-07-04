import { Router } from 'express';
import { check } from 'express-validator';
import { getTransactionsByUser, sendAmount } from '../controllers/transaction';
import { validarCampos } from '../middlewares/middelwares';
import { validarJWT } from '../middlewares/validarJwt';


const router = Router();

// send Amount
// /transactions/send/
//amount, userTarget, userOriginWallet, userTargetWallet
router.post('/send',
    [
        check(
            'amount', 'El monto es obligatorio').not().isEmpty().isNumeric(),

        check('userOriginWallet', 'La billetar de origen es obligatorio').not().isEmpty(),

        check('userTargetWallet', 'La billeta de destino es obligatorio').not().isEmpty(),

        validarCampos,
        validarJWT, 
    ], sendAmount);

///transactions/getransactions/
router.get('/gettransactions', validarJWT, getTransactionsByUser);

export default router;