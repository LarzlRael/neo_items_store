import express from 'express';
const app = express();

require('dotenv').config();
import path from 'path';
import authRoutes from './routes/auth';
import walletRoutes from './routes/wallet';
import transactionsRoutes from './routes/transaction';
import qrRoutes from './routes/qr';

//DB config
require('./database/databaseConfig').dbConnection();

const port = process.env.PORT;
//Node server

const server = require('http').createServer(app);
export const io = require('socket.io')(server);
import './sockets/socket';


/* app.set("view engine", "ejs"); */

//Lectura y parse de BODY
app.use(express.json());
//Index server index
const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));

//routes


app.use('/auth', authRoutes);
app.use('/wallet', walletRoutes);
app.use('/transactions', transactionsRoutes);
app.use('/qr', qrRoutes);



server.listen(port, () => {
    console.log(`Server on port ${port}`);
});