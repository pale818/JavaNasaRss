/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package hr.algebra.model;

/**
 *
 * @author paola
 */
public class NewsFeedUser {
    

    private int id;
    private String username;
    private String passwordHash;
    private Boolean isAdmin;
   

    public NewsFeedUser() {
    }
    
    public NewsFeedUser(String username, String passwordHash, Boolean isAdmin) {
        this.username = username;
        this.passwordHash = passwordHash;
        this.isAdmin = isAdmin;
    }
    
     public NewsFeedUser(int id, String username, String passwordHash, Boolean isAdmin) {
        this(username, passwordHash, isAdmin);
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public String getUserName() {
        return username;
    }

    public void setUserName(String username) {
        this.username = username;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public Boolean getIsAdmin() {
        return isAdmin;
    }

    public void setIsAdmin(Boolean isAdmin) {
        this.isAdmin = isAdmin;
    }

    

    @Override
    public String toString() {
        return id + " - " + username;
    }
    
}
