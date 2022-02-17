import {Worker} from 'worker_threads';

export default class ThreadManager{
    //Singleton instance
    private static instance : ThreadManager
    //Attributes
    private cache : {}
    //Class Constants
    public readonly THREAD_QUANTITY = 10;
    
    constructor(){
        ThreadManager.instance = this;
        this.cache = {};
    }

    /*
    function greeter(fn: (a: string) => void) {
        fn("Hello, World");
    }
        
    function printToConsole(s: string) {
        console.log(s);
    }
        
    greeter(printToConsole);
    */

    //Bussines logic methods
    public startThreads(pQuantity: Number){
        const listNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        for (let index = 0; index < listNumbers.length; index++) {
            const number = listNumbers[index];
            const worker = new Worker("./Case_1/src/typescriptServer/util/worker.ts", {workerData: {num: number}});
            worker.once("message", result => { console.log(`Query's result is:\n ${result}`); });
            worker.on("error", error => { console.log(error); });
            worker.on("exit", exitCode => { console.log(`It exited with code ${exitCode}`); })
          }
          console.log("Main Thread is running");
    }

    startPoolCacheThreads(){

    }

    startPoolingCacheThreads(){

    }

    //Getters
    public static getInstance(){
        if(!this.instance){
            this.instance = new ThreadManager();
        }
        return this.instance;
    }

    public getCache() : {} {
        return this.cache;
    }

    //Setters
    public setCache(pCache : {}) : void {
        this.cache = pCache;
    }
    
}