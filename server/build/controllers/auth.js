"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.renewToken = exports.login = exports.registerUser = void 0;
const bcryptjs_1 = __importDefault(require("bcryptjs"));
const usuario_1 = __importDefault(require("../models/usuario"));
const jwt_1 = require("../helpers/jwt");
const registerUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { email, password } = req.body;
    try {
        const existeEmail = yield usuario_1.default.findOne({ email });
        if (existeEmail) {
            return res.status(400).json({
                ok: false,
                msg: 'EL correo ya fue registrado'
            });
        }
        const usuario = new usuario_1.default(req.body);
        //Encriptar contraseña
        const salt = bcryptjs_1.default.genSaltSync();
        usuario.password = bcryptjs_1.default.hashSync(password, salt);
        yield usuario.save();
        //generar el JWT_KEY
        const token = yield jwt_1.generarJWT(usuario.id);
        res.json({
            ok: true,
            usuario,
            token
        });
    }
    catch (error) {
        console.log(error);
    }
});
exports.registerUser = registerUser;
const login = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { password, email } = req.body;
    const userExist = yield usuario_1.default.findOne({ email });
    if (!userExist) {
        return res.json({
            ok: false,
            msg: 'EL usuario no existe'
        });
    }
    const validPassword = bcryptjs_1.default.compareSync(password, userExist.password);
    if (!validPassword) {
        return res.status(400).json({
            ok: false,
            msg: 'Contraseña incorrecta'
        });
    }
    // generar token
    const token = yield jwt_1.generarJWT(userExist.id);
    res.json({
        ok: true,
        usuario: userExist,
        token
    });
});
exports.login = login;
const renewToken = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { uid } = req;
    // generar un nuevo JWT, generarJWT
    const token = yield jwt_1.generarJWT(uid);
    // obtener el suaurio por el UID, Usuario.findbyId...
    const usuario = yield usuario_1.default.findById(uid);
    res.json({
        ok: true,
        usuario,
        token
    });
});
exports.renewToken = renewToken;
/* com.example.neo_wallet
com.neo.neo_wallet */ 
//# sourceMappingURL=auth.js.map