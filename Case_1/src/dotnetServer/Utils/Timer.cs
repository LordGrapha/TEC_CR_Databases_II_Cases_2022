using System;
class Timer
{
    private DateTime begin;
    private DateTime end;

    public Timer(){
        this.begin = DateTime.Now;
        this.end = DateTime.Now;
    }

    public void start(){
        this.begin = DateTime.Now;
    }

    public void stop(){
        this.end = DateTime.Now;
    }

    public double getTime(){
        return ((TimeSpan)(this.end - this.begin)).TotalMilliseconds;
    }

}