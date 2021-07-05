import { Request, Response, } from 'express';


import WalletModel from '../models/walletModel';
import User from '../models/usuario';


export const createWallet = async (req: Request, res: Response) => {

    try {
        const { uid } = req;
        const newWallet = new WalletModel();
        newWallet.idUser = uid;
        newWallet.walletName = req.body.walletName;

        const newWalletCreated = await newWallet.save();

        res.json({
            ok: true,
            userWallets: newWalletCreated
        })
    } catch (error) {
        console.log(error);
    }

}
export const getWalletsByUser = async (req: Request, res: Response) => {

    try {
        const { uid } = req;
        const userWallets = await WalletModel.find({ 'idUser': uid }).sort('-createdAt');

        res.json({
            ok: true,
            userWallets

        })
    } catch (error) {
        console.log(error);
    }

}
