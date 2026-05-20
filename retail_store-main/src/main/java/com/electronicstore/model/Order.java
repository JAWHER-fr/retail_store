package com.electronicstore.model;

import java.util.Date;

public class Order {
    private int id;
    private int userId;
    private String userName;
    private double totalPrice;
    private String status;
    private Date createdAt;

    public Order(int id, int userId, String userName, double totalPrice, String status, Date createdAt) {
        this.id = id;
        this.userId = userId;
        this.userName = userName;
        this.totalPrice = totalPrice;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public int getUserId() { return userId; }
    public String getUserName() { return userName; }
    public double getTotalPrice() { return totalPrice; }
    public String getStatus() { return status; }
    public Date getCreatedAt() { return createdAt; }

    public void setId(int id) { this.id = id; }
    public void setUserId(int userId) { this.userId = userId; }
    public void setUserName(String userName) { this.userName = userName; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
    public void setStatus(String status) { this.status = status; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
