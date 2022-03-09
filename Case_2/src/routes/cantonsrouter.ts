import * as express from 'express';
import { Logger } from '../common'
import { CantonController } from '../controllers'

const app = express();
const log = new Logger();

app.get("/list", (req, res) => {
    CantonController.getInstance().listCantons()
    .then((data)=>{
        res.json(data.recordset);
    })
    .catch((err)=>{
        log.error(err);
        return "{msg: \"error\"}";
    });

});

export { app as cantonsrouter };