"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const express_validator_1 = require("express-validator");
const mailController_1 = require("../controllers/mailController");
const middelwares_1 = require("../middlewares/middelwares");
const validarJwt_1 = require("../middlewares/validarJwt");
const router = express_1.Router();
// /sendmail/
router.post('/', [
    express_validator_1.check('email', 'El email es obligatorio').isEmail(),
    middelwares_1.validarCampos
], mailController_1.SendEmailActivation);
/* router.post('/recoverypassword', [

    check('email', 'El email es obligatorio').isEmail(),
    validarCampos
], sendEmailToRecoveryPassword);
 */
router.get('/confirm/:token/:email', [
    validarJwt_1.validateIfEmailExists
], mailController_1.renderConfirmEmail);
/* router.get('/verifiedemail', [], verifiedEmail); */
router.get('/verifycheck/:token/:email', [], mailController_1.verifyCheck);
router.post('/recoverypassword/', [
    express_validator_1.check('email', 'El email es obligatorio').isEmail(),
    middelwares_1.validarCampos,
    validarJwt_1.validateIfEmailExists,
], mailController_1.sendEmailToRecoveryPassword);
router.get('/recoverypasswordform/:token/', [validarJwt_1.validarJWTEmail], mailController_1.renderRecoveryForm);
router.post('/confirmchangepassword/:token/', [
    express_validator_1.check('newPassword', 'Ingrese una nueva contraseña').not().isEmpty(),
    middelwares_1.validarCampos,
    validarJwt_1.validarJWTEmail
], mailController_1.passwordChanged);
exports.default = router;
//# sourceMappingURL=mail.js.map