import SqlProvider from './providers/SqlProvider'

class app {
    sqlProvider : SqlProvider;

    constructor(){
        this.sqlProvider = new SqlProvider();
    }
   
    async launch(){
        console.log("Case 1 - Aseni for you and our democracy World!");
        console.log("Author: Luis Diego Mora Aguilar, 2018147110");
        console.time('Query 1');
        this.sqlProvider.executeQuery1();
        console.timeEnd('Query 1');
        console.time('Query 2');
        this.sqlProvider.executeQuery2();
        console.timeEnd('Query 2');
    }
}

new app().launch();