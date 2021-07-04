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
exports.viewUserWallets = exports.createWallet = void 0;
const walletModel_1 = __importDefault(require("../models/walletModel"));
const createWallet = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { uid } = req;
        const newWallet = new walletModel_1.default();
        newWallet.idUser = uid;
        newWallet.walletName = req.body.walletName;
        const newWalletCreated = yield newWallet.save();
        res.json({
            ok: true,
            userWallets: newWalletCreated
        });
    }
    catch (error) {
        console.log(error);
    }
});
exports.createWallet = createWallet;
const viewUserWallets = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { uid } = req;
        const userWallets = yield walletModel_1.default.find({ 'idUser': uid });
        res.json({
            ok: true,
            userWallets
        });
    }
    catch (error) {
        console.log(error);
    }
});
exports.viewUserWallets = viewUserWallets;
//# sourceMappingURL=wallet.js.map