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
exports.sendAmount = void 0;
const transacionModel_1 = __importDefault(require("./../models/transacionModel"));
const walletModel_1 = __importDefault(require("./../models/walletModel"));
const mongoose_1 = __importDefault(require("mongoose"));
const sendAmount = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { amount, userOriginWallet, userTargetWallet } = req.body;
    const { uid } = req;
    /* verifyWallet(userOriginWallet, res); */
    if (verifyId(userOriginWallet) && verifyId(userTargetWallet)) {
        const newTransaction = new transacionModel_1.default();
        newTransaction.amount = amount;
        newTransaction.originUser = uid;
        //TODO verificar si el id es valido y existe en la base de datos
        // check if the id is valid and exist in the database
        newTransaction.userOriginWallet = userOriginWallet;
        newTransaction.userTargetWallet = userTargetWallet;
        const newTransactionRaw = yield newTransaction.save();
        const userTargetWAlletDB = yield walletModel_1.default.findById(userTargetWallet);
        const userOriginWAlletDB = yield walletModel_1.default.findById(userOriginWallet);
        // check if the amount is greater than the balance
        if (amount > userOriginWAlletDB.balance) {
            return res.json({
                ok: false,
                msg: 'Saldo insuficiente',
            });
        }
        //? sustraction
        userOriginWAlletDB.balance = userOriginWAlletDB.balance - amount;
        yield userOriginWAlletDB.save();
        //? add new amount 
        userTargetWAlletDB.balance = userTargetWAlletDB.balance + amount;
        yield userTargetWAlletDB.save();
        return res.json({
            ok: true,
            msg: 'Transaccion realizada con exito :D',
            newTransactionRaw
        });
    }
    else {
        return res.json({
            ok: false,
            msg: 'Veriifique las datos',
        });
    }
});
exports.sendAmount = sendAmount;
const verifyId = (id) => {
    return mongoose_1.default.Types.ObjectId.isValid(id);
};
//# sourceMappingURL=transaction.js.map