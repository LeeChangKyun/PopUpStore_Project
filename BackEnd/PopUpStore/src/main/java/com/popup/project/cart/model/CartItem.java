package com.popup.project.cart.model;

import lombok.Data;

@Data
public class CartItem {
    private String productName;
    private int price;
    private int quantity;

    public CartItem(String productName, int price, int quantity) {
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
    }

    // Cart total 계산
    public int getTotalPrice() {
        return price * quantity;
    }
}
