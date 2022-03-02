package com.case1.Entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "Cantons")
public class Cantons {
    private int id;
    private String name;
    private int politicPartiesSupport;
    private int deliverables;
    
    public Cantons() {}

    public Cantons(int id, String name, int politicPartiesSupport, int deliverables) {
        super();
        this.id = id;
        this.name = name;
        this.politicPartiesSupport = politicPartiesSupport;
        this.deliverables = deliverables;
    }

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    public int getId() {
        return id;
    }

    private void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPoliticPartiesSupport() {
        return politicPartiesSupport;
    }

    public void setPoliticPartiesSupport(int politicPartiesSupport) {
        this.politicPartiesSupport = politicPartiesSupport;
    }

    public int getDeliverables() {
        return deliverables;
    }

    public void setDeliverables(int deliverables) {
        this.deliverables = deliverables;
    }

}