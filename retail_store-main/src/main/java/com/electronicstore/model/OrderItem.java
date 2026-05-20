package com.electronicstore.model;

public class OrderItem {
    private int id;
    private int orderId;
    private Product product;
    private int quantity;
    private double price;

    public OrderItem(int id, int orderId, Product product, int quantity, double price) {
        this.id = id;
        this.orderId = orderId;
        this.product = product;
        this.quantity = quantity;
        this.price = price;
    }

    public int getId() { return id; }
    public int getOrderId() { return orderId; }
    public Product getProduct() { return product; }
    public int getQuantity() { return quantity; }
    public double getPrice() { return price; }

    public void setId(int id) { this.id = id; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public void setProduct(Product product) { this.product = product; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public void setPrice(double price) { this.price = price; }
}
