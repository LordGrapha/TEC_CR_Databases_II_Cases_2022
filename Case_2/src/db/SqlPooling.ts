import * as mssql from 'mssql';

export class SqlProvider{

    private static instance : SqlProvider = new SqlProvider();
    private config : mssql.config;
    private connection : mssql.ConnectionPool

    constructor(){
        this.config = {
            server: "localhost", // or "localhost"
            options: {
                database : "Case_1",
                trustServerCertificate : true,
                rowCollectionOnDone : true
            },
            user: "sa",
            password: "Guayaboscr123",
            pool: {                             //All Connection Pooling configs here, max, mins and timeout
                max: 10,
                min: 5,
                idleTimeoutMillis: 30000
              }
        };
        this.createPooling().then(pool => {
            this.connection = pool;
        });
    }

    private async createPooling() : Promise<mssql.ConnectionPool> {
        try {
            return mssql.connect(this.config);
        } catch (error) {
            console.log("SQLPooling Error:\n" + error);
        }
    }

    public getConnection() : mssql.ConnectionPool {
        return this.connection;
    }

    public static getInstance() : SqlProvider {
        if(!this.instance){
            this.instance = new SqlProvider();
        }
        return this.instance;
    }
}
