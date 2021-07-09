"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.io = void 0;
const express_1 = __importDefault(require("express"));
const app = express_1.default();
require('dotenv').config();
const path_1 = __importDefault(require("path"));
const auth_1 = __importDefault(require("./routes/auth"));
const wallet_1 = __importDefault(require("./routes/wallet"));
const transaction_1 = __importDefault(require("./routes/transaction"));
const qr_1 = __importDefault(require("./routes/qr"));
//DB config
require('./database/databaseConfig').dbConnection();
const port = process.env.PORT;
//Node server
const server = require('http').createServer(app);
exports.io = require('socket.io')(server);
require("./sockets/socket");
/* app.set("view engine", "ejs"); */
//Lectura y parse de BODY
app.use(express_1.default.json());
//Index server index
const publicPath = path_1.default.resolve(__dirname, 'public');
app.use(express_1.default.static(publicPath));
//routes
app.use('/auth', auth_1.default);
app.use('/wallet', wallet_1.default);
app.use('/transactions', transaction_1.default);
app.use('/qr', qr_1.default);
server.listen(port, () => {
    console.log(`Server on port ${port}`);
});
//# sourceMappingURL=index.js.map