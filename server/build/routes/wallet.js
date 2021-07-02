"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const wallet_1 = require("../controllers/wallet");
const validarJwt_1 = require("../middlewares/validarJwt");
const router = express_1.Router();
// wallet/createWallet
router.post('/createwallet', validarJwt_1.validarJWT, wallet_1.createWallet);
// wallet/walletByUsers
router.get('/walletbyuser', validarJwt_1.validarJWT, wallet_1.viewUserWallets);
exports.default = router;
//# sourceMappingURL=wallet.js.map