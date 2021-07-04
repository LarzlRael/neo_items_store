"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const express_validator_1 = require("express-validator");
const wallet_1 = require("../controllers/wallet");
const middelwares_1 = require("../middlewares/middelwares");
const validarJwt_1 = require("../middlewares/validarJwt");
const router = express_1.Router();
// wallet/createWallet
router.post('/createwallet', [
    express_validator_1.check('walletName', 'Ingrese nombre de lal billetera').not().isEmpty(), validarJwt_1.validarJWT, middelwares_1.validarCampos
], wallet_1.createWallet);
// wallet/walletByUsers
router.get('/walletbyuser', validarJwt_1.validarJWT, wallet_1.viewUserWallets);
exports.default = router;
//# sourceMappingURL=wallet.js.map