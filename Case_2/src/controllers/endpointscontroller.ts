/* eslint-disable @typescript-eslint/explicit-module-boundary-types */
import { endpoints_data } from '../repositories/endpoints_data'
import { Logger } from '../common'


export class EndpointController {
    private static instance: EndpointController = new EndpointController();
    private log: Logger;

    private constructor()
    {
        this.log = new Logger();
    }

    public static getInstance() : EndpointController
    {
        if (!this.instance)
        {
            this.instance = new EndpointController();
        }
        return this.instance;
    }

    public getEndpoint_1()
    {
        const sqlServerData = new endpoints_data();
        return sqlServerData.getEndpoint_1();
    }

    public getEndpoint_2()
    {
        const sqlServerData = new endpoints_data();
        return sqlServerData.getEndpoint_2();
    }

    public getEndpoint_3()
    {
        const sqlServerData = new endpoints_data();
        return sqlServerData.getEndpoint_3();
    }

    public getEndpoint_4()
    {
        const sqlServerData = new endpoints_data();
        return sqlServerData.getEndpoint_4();
    }

    public getEndpoint_5()
    {
        const sqlServerData = new endpoints_data();
        return sqlServerData.getEndpoint_5();
    }

    public getEndpoint_6()
    {
        const sqlServerData = new endpoints_data();
        return sqlServerData.getEndpoint_6();
    }
}