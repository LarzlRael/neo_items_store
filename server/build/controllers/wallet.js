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
exports.getWalletsByUser = exports.createWallet = void 0;
const walletModel_1 = __importDefault(require("../models/walletModel"));
const userModel_1 = __importDefault(require("../models/userModel"));
const createWallet = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { uid } = req;
        const newWallet = new walletModel_1.default();
        newWallet.idUser = uid;
        newWallet.walletName = req.body.walletName;
        const newWalletCreated = yield newWallet.save();
        const getUser = yield userModel_1.default.findById(uid);
        getUser === null || getUser === void 0 ? void 0 : getUser.wallets.push(newWalletCreated.id);
        yield (getUser === null || getUser === void 0 ? void 0 : getUser.save());
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
const getWalletsByUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { uid } = req;
        const userWallets = yield walletModel_1.default.find({ 'idUser': uid }).sort('-createdAt');
        res.json({
            ok: true,
            userWallets
        });
    }
    catch (error) {
        console.log(error);
    }
});
exports.getWalletsByUser = getWalletsByUser;
//# sourceMappingURL=wallet.js.map