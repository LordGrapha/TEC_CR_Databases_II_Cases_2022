import mssql from 'mssql';


export default class SqlProvider{
    
    private config : mssql.config;
    private pool : mssql.ConnectionPool;


    constructor(){
        this.config = {
            driver: process.env.SQL_DRIVER,
            server: process.env.SQL_SERVER,
            database: process.env.SQL_DATABASE,
            user: process.env.SQL_UID,
            password: process.env.SQL_PWD,
            options: {
                encrypt: false,
                enableArithAbort: false
            },
        };
        this.pool = new mssql.ConnectionPool(this.config);
    }

}
