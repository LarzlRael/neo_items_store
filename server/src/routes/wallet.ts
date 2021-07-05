import { Router } from 'express';
import { check } from 'express-validator';
import { createWallet, getWalletsByUser } from '../controllers/wallet';
import { validarCampos } from '../middlewares/middelwares';
import { validarJWT } from '../middlewares/validarJwt';

const router = Router();

// wallet/createWallet
router.post('/createwallet',
    [
        check('walletName', 'Ingrese nombre de lal billetera').not().isEmpty(), validarJWT, validarCampos
    ], createWallet);

// wallet/walletByUsers
router.get('/walletbyuser', validarJWT, getWalletsByUser);

export default router;