"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.validarJWT = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const validarJWT = (req, res, next) => {
    //Leer token
    const token = req.header('x-token');
    if (!token) {
        return res.status(401).json({
            ok: false,
            msg: 'No hay token en la peticion'
        });
    }
    try {
        const { uid } = jsonwebtoken_1.default.verify(token, process.env.JWT_KEY);
        req.uid = uid;
        next();
    }
    catch (error) {
        return res.status(401).json({
            ok: false,
            msg: 'Token no valido'
        });
    }
};
exports.validarJWT = validarJWT;
//# sourceMappingURL=validarJwt.js.map