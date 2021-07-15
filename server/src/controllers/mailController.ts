import { Request, Response } from 'express';
import nodemailer from 'nodemailer';
import UserModel from '../models/userModel';
import { generarJWT, comprobarJWT } from '../helpers/jwt';







const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 465,
    secure: true, // true for 465, false for other ports
    auth: {
        user: process.env.USER_MAIL_SERVER, // generated ethereal user
        pass: process.env.PASS_MAIL_SERVER // generated ethereal password
    },
});

transporter.verify(() => {
    console.log('Ready to send emails');
})


export const SendEmailActivation = async (req: Request, res: Response) => {

    const hostname = req.headers.host;
    const protocol = req.protocol;

    const myUrl = `${protocol}://${hostname}`;

    try {
        const { email } = req.body;
        const token = await generarJWT(email, '5M');
        transporter.sendMail({
            from: 'N.E.O', // sender address
            to: email, // list of receivers
            subject: "Activacion de email", // Subject line
            /* text: "Hello world?", // plain text body */
            html: `<p>
            Para activar tu cuenta ingrese a <a href="${myUrl}/sendmail/confirm/${token}/${email}">verificar email</a>
            </p>`, // html body
        });
        res.json({
            ok: true,
            msg: 'email sent, review your email'
        })
    } catch (error) {
        res.status(400).json({ ok: false, msg: error })

    }
}
export const sendEmailToRecoveryPassword = async (req: Request, res: Response) => {

    try {
        const { email } = req.body;

        const findEmail = await UserModel.findOne({ email: email });

        if (findEmail) {
            transporter.sendMail({
                from: '"Fred Foo 👻" <foo@example.com>', // sender address
                to: email, // list of receivers
                subject: "testing", // Subject line
                /* text: "Hello world?", // plain text body */
                html: "<b>Hello world from node mailer, yor has chossen for a testing user</b>", // html body
            });
            res.json({
                ok: true,
                msg: 'email sent, review your email'
            });
        } else {
            res.status(400).json({ ok: false, msg: 'No hay ninguna cuenta registrada con ese correo' })
        }
    } catch (error) {
        res.status(400).json({ ok: false, msg: error })

    }
}


export const renderConfirmEmail = async (req: Request, res: Response) => {

    const { token, email } = req.params;

    res.render('index', {
        token,
        email
    });
}

export const verifyCheck = async (req: Request, res: Response) => {
    const { token, email } = req.params;

    const getUserWithThatEmail = await UserModel.findOne({ email });

    getUserWithThatEmail!.activated = true;

    await getUserWithThatEmail?.save();

    if (comprobarJWT(token)) {

        // TODO emit the socket event

     


        var io = require('socket.io');
        res.redirect('/sendmail/verifiedemail');


    } else {
        res.send('Error');
    }
    /* res.render('index'); */
}


export const verifiedEmail = async (req: Request, res: Response) => {
    res.render('verifiedemail');
}