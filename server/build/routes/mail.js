"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const express_validator_1 = require("express-validator");
const mailController_1 = require("../controllers/mailController");
const middelwares_1 = require("../middlewares/middelwares");
const router = express_1.Router();
// /sendmail/
router.post('/', [
    express_validator_1.check('email', 'El email es obligatorio').isEmail(),
    middelwares_1.validarCampos
], mailController_1.SendEmailActivation);
router.post('/recoverypassword', [
    express_validator_1.check('email', 'El email es obligatorio').isEmail(),
    middelwares_1.validarCampos
], mailController_1.sendEmailToRecoveryPassword);
router.get('/confirm/:token/:email', [], mailController_1.renderConfirmEmail);
router.get('/verifiedemail', [], mailController_1.verifiedEmail);
router.get('/verifycheck/:token/:email', [], mailController_1.verifyCheck);
exports.default = router;
//# sourceMappingURL=mail.js.map