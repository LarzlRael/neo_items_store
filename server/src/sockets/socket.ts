import { Socket } from 'dgram';
import { io } from '..';



io.on('connection', (socket: Socket) => {

    console.log('a user connected');


    socket.on('transaction-real-time', async (payload) => {

        console.log('emitiendo los valores');
        socket.emit('transaction-real-time', payload);
        
    });

    socket.on('testing', () => {

        console.log('tesint this ')

    });

    socket.on('disconnect', () => {
        console.log('user disconnected');
    });
});