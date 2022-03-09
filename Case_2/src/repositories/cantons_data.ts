import * as mssql from 'mssql';
import { SqlProvider } from "../db"


export class cantons_data {

    private sqlPool : SqlProvider;
    private sqlConnection : mssql.ConnectionPool;

    public constructor()
    {
        // via singleton, accediendo a un solo pool tengo una conexiona la base de datos
        this.sqlPool = SqlProvider.getInstance();
        this.sqlConnection = this.sqlPool.getConnection();
    }

    public async getAllCantons() : Promise<mssql.IResult<any>>
    {
        // llamadas a SP, driver de base de datos, ORM
        try {
            return await this.sqlConnection.request()
                                .query("SELECT * FROM Cantons");
        } catch (error) {
            console.log("Cantons_data Error:\n" + error);
        }
    }

}