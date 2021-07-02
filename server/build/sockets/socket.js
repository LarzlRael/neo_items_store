"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const __1 = require("..");
__1.io.on('connection', (socket) => {
    console.log('a user connected');
    socket.on('disconnect', () => {
        console.log('user disconnected');
    });
});
//# sourceMappingURL=socket.js.map