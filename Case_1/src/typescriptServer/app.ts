import ThreadManager from "./util/Thread";

class app {

    threadManager : ThreadManager = ThreadManager.getInstance();
   
    constructor() {
        this.launch();
    }
   
    launch(){
        console.log("Case 1 - Aseni for you and our democracy World!");
        console.log("Author: Luis Diego Mora Aguilar, 2018147110");
        console.log("Stored Procedure, 10 threads:");
        this.threadManager.startThreads(this.threadManager.THREAD_QUANTITY);
    }
}

const sv = new app();