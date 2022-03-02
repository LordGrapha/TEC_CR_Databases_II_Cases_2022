import SqlProvider from './providers/SqlProvider'
import Timer from './util/Timer'

class app {
    sqlProvider : SqlProvider;

    constructor(){
        this.sqlProvider = new SqlProvider();
    }
   
    launch(){
        console.log("Case 1 - Aseni for you and our democracy World!");
        console.log("Author: Luis Diego Mora Aguilar, 2018147110");
        console.log("Stored Procedure, 10 threads:");
        const timer = new Timer();
        timer.start();
        this.sqlProvider.executeQuery1();
        timer.stop();
        console.log("\n\nQuery 1 - 10 Threads took: " + timer.getTime() + "ms\n\n");

        timer.start();
        this.sqlProvider.executeQuery2();
        timer.stop();
        console.log("\n\nQuery 2 - 10 Threads with Pool took: " + timer.getTime() + "ms\n\n");

        timer.start();
        this.sqlProvider.executeQuery3();
        timer.stop();
        console.log("\n\nQuery 3 - ORM - 10 Threads with Pool and Cache took: " + timer.getTime() + "ms\n\n");    
    }
}

new app().launch();