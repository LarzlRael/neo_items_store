import axios from 'axios';
import { IpushNotification } from '../interfaces/pushNotification';


export const sendPushNotification = async (devicesTargets: String[] | undefined, nameOrigin: any, saldo: string) => {

    const sendData: IpushNotification = {
        registration_ids: devicesTargets!,
        notification: {
            title: `Saldo recibido`,
            body: `EL usuario ${nameOrigin} te envio ${saldo} BS`,
        }
    };

    try {
        await axios({
            method: 'POST',
            url: 'https://fcm.googleapis.com/fcm/send',
            data: sendData,
            headers: {
                Authorization: `key=${process.env.FIREBASE_TOKEN}`
            }

        });
    } catch (error) {
        console.log(error);
    }


    //TODO set unique id device by user

}

