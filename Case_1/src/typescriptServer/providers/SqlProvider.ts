import mssql from 'mssql';

export default class SqlProvider{
    
    private config : mssql.config;
    private CANTONS : String[]


    constructor(){
        this.config = {
            server: "localhost", // or "localhost"
            options: {
                database : "Case_1",
                trustServerCertificate : true,
                rowCollectionOnDone : true
            },
            user: "sa",
            password: "Guayaboscr123"
        };
        this.CANTONS = ["Abangares", "Acosta (San José, CR)",
                    "Alajuela (Alajuela, CR)", "Alajuelita (San José, CR)",
                    "Alvarado (Cartago, CR)", "Aserrí (San José, CR)",
                    "Atenas (Alajuela, CR)", "Bagaces (Guanacaste, CR)",
                    "Barva (Heredia, CR)", "Belén (Heredia, CR)"]
    }

    async executeQuery1(){
        for (let threadIndex = 0; threadIndex < this.CANTONS.length; threadIndex++) {
            console.log("Thread " + threadIndex + " is running");
            await this.query1(threadIndex);
        }
    }
    
    async query1(pThreadIndex : number) : Promise<void> {
        const canton = this.CANTONS[pThreadIndex];
        const sql = mssql;
        sql.on('error', err => {
            console.log(err)
        })
        sql.connect(this.config).then(pool => {
            // Stored procedure
            return pool.request()
                .input('cantonName', sql.VarChar, canton)
                .execute('[dbo].[Query1]')
        }).then(result => {
            result.recordsets.forEach(element => {
                console.table(element)
            });
        }).catch(err => {
            console.log(err)
        })
    }

}
