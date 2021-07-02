import { io } from '..';






io.on('connection', (socket: any) => {

    console.log('a user connected');

    socket.on('disconnect', () => {
        console.log('user disconnected');
    });
});