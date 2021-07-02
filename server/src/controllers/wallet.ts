import { Request, Response, } from 'express';


import WalletModel from '../models/walletModel';
import User from '../models/usuario';


export const createWallet = async (req: Request, res: Response) => {

    try {
        const { uid } = req;
        const newWallet = new WalletModel();
        newWallet.idUser = uid;

        const newWalletCreated = await newWallet.save();

        res.json({
            ok: true,
            newWalletCreated

        })
    } catch (error) {
        console.log(error);
    }

}
export const viewUserWallets = async (req: Request, res: Response) => {

    try {
        const { uid } = req;
        const newWallet = await WalletModel.find({ 'idUser': uid });

        res.json({
            ok: true,
            newWallet

        })
    } catch (error) {
        console.log(error);
    }

}
