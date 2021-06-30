const express = require('express');
const app = express();
const port = process.env.PORT || 4000;
const path = require('path');

//Node server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);
require('./src/sockets/socket');

//Index server index
const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));

//routes

app.use('/auth', require('./src/routes/auth'));
server.listen(port, () => {
    console.log(`Server on port ${port}`);
});