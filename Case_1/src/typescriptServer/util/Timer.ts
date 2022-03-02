export default class Timer {

    private begin : number;
    private end : number;

    constructor() {
        this.begin = new Date().getTime();
        this.end = new Date().getTime();   
    }

    public start(){
        this.begin = new Date().getTime();
    }

    public stop(){
        this.end = new Date().getTime(); 
    }

    public getTime() : Number {
        return this.end - this.begin;
    }

}


