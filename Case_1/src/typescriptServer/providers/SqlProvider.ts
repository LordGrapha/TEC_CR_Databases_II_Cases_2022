import mssql, { Promise } from 'mssql';
import Timer from '../util/Timer';

export default class SqlProvider{
    
    private config : mssql.config;
    private CANTONS : String[]
    private QUERY2 : string =   "SELECT c.name, COUNT(d.id) as deliverables FROM Cantons as c " +
                                "INNER JOIN [dbo].[CantonsXDeliverables] as cxd ON c.id = cxd.cantonId " +
                                "INNER JOIN [dbo].[Deliverables] as d ON cxd.deliverableid = d.id " +
                                "WHERE c.politicPartiesSupport <= (SELECT FLOOR(COUNT(id) * 0.25) FROM [dbo].[PoliticParties]) " +
                                "GROUP BY c.name;";


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
        this.CANTONS = ["Abangares", "Acosta (San José, CR)",
                    "Alajuela (Alajuela, CR)", "Alajuelita (San José, CR)",
                    "Alvarado (Cartago, CR)", "Aserrí (San José, CR)",
                    "Atenas (Alajuela, CR)", "Bagaces (Guanacaste, CR)",
                    "Barva (Heredia, CR)", "Belén (Heredia, CR)"];
    }

    async executeQuery1(){

        for (let threadIndex = 0; threadIndex < this.CANTONS.length; threadIndex++) {
            await this.query1(threadIndex);
        }
    }
    
    async query1(pThreadIndex : number) : Promise<any> {
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

    async executeQuery2(){
        for (let threadIndex = 0; threadIndex < this.CANTONS.length; threadIndex++) {
            await this.query2(threadIndex);
        }

    }
    
    async query2(pThreadIndex : number) : Promise<any> {
        const canton = this.CANTONS[pThreadIndex];
        const sql = mssql;
        sql.on('error', err => {
            console.log(err)
        })
        sql.connect(this.config).then(pool => {
            // Inline Query
            //Pooling config is inside attribute this.config
            return pool.request()
                .query(this.QUERY2)
        }).then(result => {
            console.table(result.recordset);
        }).catch(err => {
            console.log(err)
        })
    }

}
