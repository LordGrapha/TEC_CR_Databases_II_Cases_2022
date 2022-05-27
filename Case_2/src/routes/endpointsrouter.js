"use strict";
exports.__esModule = true;
exports.endpointsrouter = void 0;
var express = require("express");
var common_1 = require("../common");
var controllers_1 = require("../controllers");
var app = express();
exports.endpointsrouter = app;
var log = new common_1.Logger();
app.get("/endpoint_1", function (req, res) {
    controllers_1.EndpointController.getInstance().getEndpoint_1()
        .then(function (data) {
        res.json(data.recordsets);
    })["catch"](function (err) {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
app.get("/endpoint_2", function (req, res) {
    controllers_1.EndpointController.getInstance().getEndpoint_2()
        .then(function (data) {
        res.json(data.recordsets);
    })["catch"](function (err) {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
app.post("/endpoint_3", function (req, res) {
    controllers_1.EndpointController.getInstance().getEndpoint_3(req.body.word)
        .then(function (data) {
        res.json(data);
    })["catch"](function (err) {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
app.get("/endpoint_4", function (req, res) {
    controllers_1.EndpointController.getInstance().getEndpoint_4()
        .then(function (data) {
        res.json(data.recordsets);
    })["catch"](function (err) {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
app.get("/endpoint_5", function (req, res) {
    controllers_1.EndpointController.getInstance().getEndpoint_5()
        .then(function (data) {
        res.json(data.recordsets);
    })["catch"](function (err) {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
app.post("/endpoint_6", function (req, res) {
    controllers_1.EndpointController.getInstance().getEndpoint_6(req.body.citizenid, req.body.actionid)
        .then(function (data) {
        res.json(data.recordsets);
    })["catch"](function (err) {
        log.error(err);
        return "{msg: \"error\"}";
    });
});
