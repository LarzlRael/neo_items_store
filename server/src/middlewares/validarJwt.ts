import jwt from 'jsonwebtoken';
import { Request, Response } from 'express';
import { IPayload } from '../interfaces/interfaces';

export const validarJWT = (req: Request, res: Response, next: any) => {

    //Leer token

    const token = req.header('x-token');

    if (!token) {
        return res.status(401).json({
            ok: false,
            msg: 'No hay token en la peticion'
        });
    }

    try {
        const { uid } = jwt.verify(token, process.env.JWT_KEY!) as IPayload;
        req.uid = uid;
        
        next();


    } catch (error) {
        return res.status(401).json({
            ok: false,
            msg: 'Token no valido'
        })
    }

}
