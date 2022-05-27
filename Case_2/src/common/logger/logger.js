"use strict";
exports.__esModule = true;
exports.Logger = void 0;
var Logger = /** @class */ (function () {
    function Logger() {
    }
    Logger.prototype.info = function (logText) {
        console.log({ "date": new Date(), "level": "info", "message": logText });
    };
    Logger.prototype.debug = function (logText) {
        console.log({ "date": new Date(), "level": "debug", "message": logText });
        // cloudwath
        // base de datos
        // archivo bitacora
    };
    Logger.prototype.error = function (logText) {
        console.log({ "date": new Date(), "level": "error", "message": logText });
    };
    return Logger;
}());
exports.Logger = Logger;
