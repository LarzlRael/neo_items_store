import { Request, Response } from 'express';
import TransactionModel from './../models/transacionModel';
import WalletModel from './../models/walletModel';
import mongoose from 'mongoose';

export const sendAmount = async (req: Request, res: Response) => {

    const { amount, userOriginWallet, userTargetWallet } = req.body;

    const { uid } = req;

    /* verifyWallet(userOriginWallet, res); */

    if (verifyId(userOriginWallet) && verifyId(userTargetWallet)) {

        verifyWallet(userTargetWallet, res);
        verifyWallet(userOriginWallet, res);

        const newTransaction = new TransactionModel();

        newTransaction.amount = amount;

        newTransaction.originUser = uid;


        //TODO verificar si el id es valido y existe en la base de datos
        // check if the id is valid and exist in the database


        newTransaction.userOriginWallet = userOriginWallet;
        newTransaction.userTargetWallet = userTargetWallet;


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

        newTransaction.destinyUser = userTargetWAlletDB!.idUser;

        userTargetWAlletDB!.balance = userTargetWAlletDB!.balance + amount;
        await userTargetWAlletDB!.save();

        // save new transaction 
        const newTransactionRaw = await newTransaction.save();

        return res.json({
            ok: true,
            msg: 'Transaccion realizada con exito :D',
            newTransactionRaw
        });

    }
    else {
        return res.json({
            ok: false,
            msg: 'Verifique las datos',
        });
    }
}


export const getTransactionsByUser = async (req: Request, res: Response) => {

    const { uid } = req;


    const getuserTransaction = await TransactionModel.find({

        $or: [{ originUser: uid }, { destinyUser: uid }],

    }).sort('-createdAt ');

    res.json({
        ok: true,
        userTransactions: getuserTransaction
    })
}



// 
const verifyId = (id: any): boolean => {
    return mongoose.Types.ObjectId.isValid(id);
}

const verifyWallet = async (id: any, res: Response): Promise<boolean | Object> => {
    const userOriginWAlletDB = await WalletModel.findById(id);

    if (userOriginWAlletDB) {
        return true;
    } else {
        return res.json({
            ok: true,
            msg: 'billetera no encontrada'
        })
    }

}

export const getTransactionsHistory = async (req: Request, res: Response) => {

    const transactionsHistory = await TransactionModel.find().sort('-createdAt');

    res.json({
        ok: true,
        userTransactions: transactionsHistory
    })


}