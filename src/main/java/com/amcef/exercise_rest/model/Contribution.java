package com.amcef.exercise_rest.model;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity
public class Contribution {

    @Id
    int id;
    int userId;
    String title;
    String body;

    public Contribution(int ID, int userId, String title, String body) {
        this.id = ID;
        this.userId = userId;
        this.title = title;
        this.body = body;
    }

    public Contribution() {
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public int getID() {
        return id;
    }

    public void setID(int ID) {
        this.id = ID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
