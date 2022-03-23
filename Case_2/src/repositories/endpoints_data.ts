/* eslint-disable @typescript-eslint/explicit-module-boundary-types */
import * as mssql from 'mssql';
import { SqlProvider } from "../db"


export class endpoints_data {

    private sqlPool : SqlProvider;
    private sqlConnection : mssql.ConnectionPool;

    public constructor()
    {
        // via singleton, accediendo a un solo pool tengo una conexiona la base de datos
        this.sqlPool = SqlProvider.getInstance();
        this.sqlConnection = this.sqlPool.getConnection();
    }

    public async getEndpoint_1()
    {
        return this.sqlConnection.request()
            .execute('[dbo].[Endpoint_1]')

    }

    public async getEndpoint_2()
    {
        return this.sqlConnection.request()
            .execute('[dbo].[Endpoint_2]')

    }

    public async getEndpoint_3(pWord : any)
    {
        return this.sqlConnection.request()
            .input("pEntrada", mssql.VarChar, pWord)
            .execute('[dbo].[Endpoint_3]')
            .then(result => {
                return result.recordsets;
            }).catch(err => {
                console.log(err)
            })
    }

    public async getEndpoint_4()
    {
        return this.sqlConnection.request()
            .execute('[dbo].[Endpoint_4]')
    }

    public async getEndpoint_5()
    {
        return this.sqlConnection.request()
            .execute('[dbo].[Endpoint_5]')
    }

    public async getEndpoint_6(pCitizen : any, pAction : any)
    {
        console.log("Citizenid: " + pCitizen);
        
        console.log("Actionid: " + pAction);
        
        return this.sqlConnection.request()
            .input("citizenid", mssql.Int, pCitizen)
            .input("actionid", mssql.Int, pAction)
            .execute('[dbo].[Endpoint_6_entry]')
    }

}