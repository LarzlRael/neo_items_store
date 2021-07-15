import { Router } from 'express';
import { check } from 'express-validator';
import { renderConfirmEmail, SendEmailActivation, sendEmailToRecoveryPassword, verifiedEmail, verifyCheck } from '../controllers/mailController';
import { validarCampos } from '../middlewares/middelwares';


const router = Router();
// /sendmail/
router.post('/', [

    check('email', 'El email es obligatorio').isEmail(),
    validarCampos
], SendEmailActivation);

router.post('/recoverypassword', [

    check('email', 'El email es obligatorio').isEmail(),
    validarCampos
], sendEmailToRecoveryPassword);

router.get('/confirm/:token/:email', [

], renderConfirmEmail);

router.get('/verifiedemail', [], verifiedEmail);

router.get('/verifycheck/:token/:email', [


], verifyCheck);


export default router;


