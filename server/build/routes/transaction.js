"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const express_validator_1 = require("express-validator");
const transaction_1 = require("../controllers/transaction");
const middelwares_1 = require("../middlewares/middelwares");
const validarJwt_1 = require("../middlewares/validarJwt");
const router = express_1.Router();
// send Amount
// /send/transactions
//amount, userTarget, userOriginWallet, userTargetWallet
router.post('/send', [
    express_validator_1.check('amount', 'El monto es obligatorio').not().isEmpty().isNumeric(),
    express_validator_1.check('userOriginWallet', 'La billetar de origen es obligatorio').not().isEmpty(),
    express_validator_1.check('userTargetWallet', 'La billeta de destino es obligatorio').not().isEmpty(),
    middelwares_1.validarCampos,
    validarJwt_1.validarJWT
], transaction_1.sendAmount);
exports.default = router;
//# sourceMappingURL=transaction.js.map