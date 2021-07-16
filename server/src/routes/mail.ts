import { Router } from 'express';
import { check } from 'express-validator';
import { passwordChanged, renderConfirmEmail, renderRecoveryForm, SendEmailActivation, sendEmailToRecoveryPassword, verifiedEmail, verifyCheck } from '../controllers/mailController';
import { validarCampos } from '../middlewares/middelwares';
import { validarJWTEmail, validateIfEmailExists } from '../middlewares/validarJwt';


const router = Router();
// /sendmail/
router.post('/', [

    check('email', 'El email es obligatorio').isEmail(),
    validarCampos
], SendEmailActivation);

/* router.post('/recoverypassword', [

    check('email', 'El email es obligatorio').isEmail(),
    validarCampos
], sendEmailToRecoveryPassword);
 */
router.get('/confirm/:token/:email', [
    validateIfEmailExists
], renderConfirmEmail);

/* router.get('/verifiedemail', [], verifiedEmail); */

router.get('/verifycheck/:token/:email', [], verifyCheck);


router.post('/recoverypassword/', [
    check('email', 'El email es obligatorio').isEmail(),
    validarCampos,
    validateIfEmailExists,
], sendEmailToRecoveryPassword);

router.get('/recoverypasswordform/:token/', [validarJWTEmail], renderRecoveryForm);

router.post('/confirmchangepassword/:token/', [
    check('newPassword', 'Ingrese una nueva contraseña').not().isEmpty(),
    validarCampos,
    validarJWTEmail
], passwordChanged);


export default router;


