package com.case1.Utils;

import com.google.common.cache.CacheBuilder;
import com.google.common.cache.CacheLoader;
import com.google.common.cache.LoadingCache;

public class ThreadCache {

    private CacheLoader<Integer, Thread> loader;
    private LoadingCache<Integer, Thread> cache;

    public ThreadCache(int pMaxSize){
        this.loader = new CacheLoader<Integer, Thread>() {
            @Override
            public Thread load(Integer key) {
                return new Thread();
            }
        };
        this.cache = CacheBuilder.newBuilder()
        .maximumSize(pMaxSize)
        .build(loader);
        fillThreads(pMaxSize);
    }

    public ThreadCache(){
        this.loader = new CacheLoader<Integer, Thread>() {
            @Override
            public Thread load(Integer key) {
                return new Thread();
            }
        };
        this.cache = CacheBuilder.newBuilder()
        .maximumSize(20)
        .build(loader);
        fillThreads(20);
    }

    private void fillThreads(int pQuantity){

    }
    
    public LoadingCache<Integer, Thread> getCache() {
        return cache;
    }

    public void put(Integer pKey, Thread pValue){
        this.cache.put(pKey, pValue);
    }

    public Thread get(Integer pKey){
        return this.cache.getIfPresent(pKey);
    }

}
