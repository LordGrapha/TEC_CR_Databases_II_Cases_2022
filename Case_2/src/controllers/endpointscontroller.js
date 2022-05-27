"use strict";
exports.__esModule = true;
exports.EndpointController = void 0;
/* eslint-disable @typescript-eslint/explicit-module-boundary-types */
var endpoints_data_1 = require("../repositories/endpoints_data");
var common_1 = require("../common");
var EndpointController = /** @class */ (function () {
    function EndpointController() {
        this.log = new common_1.Logger();
    }
    EndpointController.getInstance = function () {
        if (!this.instance) {
            this.instance = new EndpointController();
        }
        return this.instance;
    };
    EndpointController.prototype.getEndpoint_1 = function () {
        var sqlServerData = new endpoints_data_1.endpoints_data();
        return sqlServerData.getEndpoint_1();
    };
    EndpointController.prototype.getEndpoint_2 = function () {
        var sqlServerData = new endpoints_data_1.endpoints_data();
        return sqlServerData.getEndpoint_2();
    };
    EndpointController.prototype.getEndpoint_3 = function (pWord) {
        var sqlServerData = new endpoints_data_1.endpoints_data();
        return sqlServerData.getEndpoint_3(pWord);
    };
    EndpointController.prototype.getEndpoint_4 = function () {
        var sqlServerData = new endpoints_data_1.endpoints_data();
        return sqlServerData.getEndpoint_4();
    };
    EndpointController.prototype.getEndpoint_5 = function () {
        var sqlServerData = new endpoints_data_1.endpoints_data();
        return sqlServerData.getEndpoint_5();
    };
    EndpointController.prototype.getEndpoint_6 = function (pCitizen, pAction) {
        var sqlServerData = new endpoints_data_1.endpoints_data();
        return sqlServerData.getEndpoint_6(pCitizen, pAction);
    };
    EndpointController.instance = new EndpointController();
    return EndpointController;
}());
exports.EndpointController = EndpointController;
