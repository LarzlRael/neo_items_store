"use strict";
exports.__esModule = true;
exports.validarJWT = void 0;
var jsonwebtoken_1 = require("jsonwebtoken");
var validarJWT = function (req, res, next) {
    //Leer token
    var token = req.header('x-token');
    if (!token) {
        return res.status(401).json({
            ok: false,
            msg: 'No hay token en la peticion'
        });
    }
    try {
        var uid = jsonwebtoken_1["default"].verify(token, process.env.JWT_KEY).uid;
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
