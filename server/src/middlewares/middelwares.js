"use strict";
exports.__esModule = true;
exports.validarCampos = void 0;
var express_validator_1 = require("express-validator");
var validarCampos = function (req, res, next) {
    var errores = express_validator_1.validationResult(req);
    if (!errores.isEmpty()) {
        return res.status(400).json({
            ok: false,
            errors: errores.mapped()
        });
    }
    next();
};
exports.validarCampos = validarCampos;
