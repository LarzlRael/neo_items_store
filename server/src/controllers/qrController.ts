import { Request, Response } from 'express';
import qrcode from 'qrcode';

export const generateQR = (req: Request, res: Response) => {

    const { url } = req.body;

    if (url.length === 0) res.send("Empty Data!");
    qrcode.toDataURL(url, {
        scale: 10
    }, (err, src) => {
        if (err) res.send("Error occured");

        const onlyBase64Png = src.split(',');
        res.json({
            ok: true,
            src: onlyBase64Png[1]
        });
    });
}