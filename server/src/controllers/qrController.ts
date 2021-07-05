import { Request, Response } from 'express';
import qrcode from 'qrcode';

export const generateQR = async (req: Request, res: Response) => {

    const { url } = req.body;

    if (url.length === 0) {
        res.json({
            ok: false,
            msg: 'El url ingresado esta vacio'
        });
    }
    const srcImage = await qrcode.toDataURL(url, {
        scale: 10
    });

    const onlyBase64Png = srcImage.split(',');
    res.json({
        ok: true,
        srcImage: onlyBase64Png[1]
    });
}