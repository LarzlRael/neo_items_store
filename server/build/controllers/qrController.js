"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateQR = void 0;
const qrcode_1 = __importDefault(require("qrcode"));
const generateQR = (req, res) => {
    const { url } = req.body;
    if (url.length === 0)
        res.send("Empty Data!");
    qrcode_1.default.toDataURL(url, {
        scale: 10
    }, (err, src) => {
        if (err)
            res.send("Error occured");
        const onlyBase64Png = src.split(',');
        res.json({
            ok: true,
            src: onlyBase64Png[1]
        });
    });
};
exports.generateQR = generateQR;
//# sourceMappingURL=qrController.js.map