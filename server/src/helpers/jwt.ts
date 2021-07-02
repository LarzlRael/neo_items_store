import jwt from 'jsonwebtoken';
import { IPayload } from '../interfaces/jwt';

export const generarJWT = (uid: any) => {
    return new Promise((resolve, reject) => {
        const payload = { uid };

        jwt.sign(payload, process.env.JWT_KEY!, {
            expiresIn: '24h'
        }, (err, token) => {
            if (err) {
                reject('No se pudo generar el JWT');
            } else {
                resolve(token);
            }
        });
    })
}


export const comprobarJWT = (token: string = '') => {


    try {
        const { uid } = jwt.verify(token, process.env.JWT_KEY!) as IPayload;
        return [true, uid];
    } catch (error) {
        return [false, null];
    }
}