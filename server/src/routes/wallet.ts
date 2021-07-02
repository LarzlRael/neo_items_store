import { Router } from 'express';
import { createWallet, viewUserWallets } from '../controllers/wallet';
import { validarJWT } from '../middlewares/validarJwt';

const router = Router();

// wallet/createWallet
router.post('/createwallet', validarJWT, createWallet);

// wallet/walletByUsers
router.get('/walletbyuser', validarJWT, viewUserWallets);

export default router;