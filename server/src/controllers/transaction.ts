import { Request, Response } from 'express';
import TransactionModel from './../models/transacionModel';
import WalletModel from './../models/walletModel';
import mongoose from 'mongoose';

export const sendAmount = async (req: Request, res: Response) => {

    const { amount, userOriginWallet, userTargetWallet } = req.body;

    const { uid } = req;
    /* verifyWallet(userOriginWallet, res); */

    if (verifyId(userOriginWallet) && verifyId(userTargetWallet)) {


        const newTransaction = new TransactionModel();

        newTransaction.amount = amount;

        newTransaction.originUser = uid;

        //TODO verificar si el id es valido y existe en la base de datos
        // check if the id is valid and exist in the database


        newTransaction.userOriginWallet = userOriginWallet;
        newTransaction.userTargetWallet = userTargetWallet;

        const newTransactionRaw = await newTransaction.save();

        const userTargetWAlletDB = await WalletModel.findById(userTargetWallet);

        const userOriginWAlletDB = await WalletModel.findById(userOriginWallet);

        // check if the amount is greater than the balance

        if (amount > userOriginWAlletDB!.balance) {
            return res.json({
                ok: false,
                msg: 'Saldo insuficiente',
            });
        }
        //? sustraction
        userOriginWAlletDB!.balance = userOriginWAlletDB!.balance - amount;
        await userOriginWAlletDB!.save();

        //? add new amount 
        userTargetWAlletDB!.balance = userTargetWAlletDB!.balance + amount;
        await userTargetWAlletDB!.save();

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
}


const verifyId = (id: any) => {
    return mongoose.Types.ObjectId.isValid(id);
}