package com.cosmeticshop.cosmetic_shop.dto;

import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class CartItemDTO {
    private Long cartItemId;
    private Integer quantity;
    private BigDecimal price;
    private BigDecimal totalOfCartContainThisCartItem;

    public CartItemDTO() {
    }

    public CartItemDTO(Long cartItemId, Integer quantity, BigDecimal price, BigDecimal totalOfCartContainThisCartItem) {
        this.cartItemId = cartItemId;
        this.quantity = quantity;
        this.price = price;
        this.totalOfCartContainThisCartItem = totalOfCartContainThisCartItem;
    }

    public Long getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(Long cartItemId) {
        this.cartItemId = cartItemId;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getTotalOfCartContainThisCartItem() {
        return totalOfCartContainThisCartItem;
    }

    public void setTotalOfCartContainThisCartItem(BigDecimal totalOfCartContainThisCartItem) {
        this.totalOfCartContainThisCartItem = totalOfCartContainThisCartItem;
    }
}
