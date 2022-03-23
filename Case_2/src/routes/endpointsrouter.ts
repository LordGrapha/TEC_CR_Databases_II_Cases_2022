import * as express from 'express';
import { Logger } from '../common'
import { EndpointController } from '../controllers'

const app = express();
const log = new Logger();

app.get("/endpoint_1", (req, res) => {
    EndpointController.getInstance().getEndpoint_1()
    .then((data)=>{
        res.json(data.recordsets);
    })
    .catch((err)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });

});

app.get("/endpoint_2", (req, res) => {
    EndpointController.getInstance().getEndpoint_2()
    .then((data)=>{
        res.json(data.recordsets);
    })
    .catch((err)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });

});

app.post("/endpoint_3", (req, res) => {
    EndpointController.getInstance().getEndpoint_3(req.body.word)
    .then((data)=>{
        res.json(data);
    })
    .catch((err)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });

});

app.get("/endpoint_4", (req, res) => {
    EndpointController.getInstance().getEndpoint_4()
    .then((data)=>{
        res.json(data.recordsets);
    })
    .catch((err)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });

});

app.get("/endpoint_5", (req, res) => {
    EndpointController.getInstance().getEndpoint_5()
    .then((data)=>{
        res.json(data.recordsets);
    })
    .catch((err)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });

});

app.post("/endpoint_6", (req, res) => { 
    EndpointController.getInstance().getEndpoint_6(req.body.citizenid, req.body.actionid)
    .then((data)=>{
        if(data.recordset)
        res.json(data.recordsets);
    })
    .catch((err)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });

});

export { app as endpointsrouter };