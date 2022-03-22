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
        this.sqlConnection.request()
            .execute('[dbo].[Endpoint_1]')
            .then(result => {
                return result.recordsets;
            }).catch(err => {
                console.log(err)
            })
    }

    public async getEndpoint_2()
    {
        this.sqlConnection.request()
            .execute('[dbo].[Endpoint_2]')
            .then(result => {
                return result.recordsets;
            }).catch(err => {
                console.log(err)
            })
    }

    public async getEndpoint_3()
    {
        this.sqlConnection.request()
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
        this.sqlConnection.request()
            .execute('[dbo].[Endpoint_5]')
            .then(result => {
                return result.recordsets;
            }).catch(err => {
                console.log(err)
            })
    }

    public async getEndpoint_6()
    {
        this.sqlConnection.request()
            .execute('[dbo].[Endpoint_6]')
            .then(result => {
                return result.recordsets;
            }).catch(err => {
                console.log(err)
            })
    }

}