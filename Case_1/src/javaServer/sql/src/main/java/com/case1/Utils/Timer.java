package com.case1.Utils;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;

public class Timer {
    private LocalDateTime begin;
    private LocalDateTime end;

    public Timer(){
        this.begin = LocalDateTime.now();
        this.end = LocalDateTime.now();
    }

    public void start(){
        this.begin = LocalDateTime.now();
    }

    public void stop(){
        this.end = LocalDateTime.now();
    }

    public int getMiliSeconds(){
        return (int) ChronoUnit.MILLIS.between(this.begin, this.end);
    }
}
