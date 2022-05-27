"use strict";
exports.__esModule = true;
var app_1 = require("./app");
var http = require("http");
var common_1 = require("./common");
var port = 5000;
var logger = new common_1.Logger();
app_1["default"].set('port', port);
var server = http.createServer(app_1["default"]);
server.listen(port);
server.on('listening', function () {
    var addr = server.address();
    var bind = (typeof addr === 'string') ? "pipe " + addr : "port " + addr.port;
    logger.info("Listening on " + bind);
});
module.exports = app_1["default"];
