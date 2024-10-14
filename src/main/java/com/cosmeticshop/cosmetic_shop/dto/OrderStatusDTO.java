package com.cosmeticshop.cosmetic_shop.dto;

import com.cosmeticshop.cosmetic_shop.entity.Order;
import org.springframework.stereotype.Component;

@Component
public class OrderStatusDTO {
    private Order order;
    private String currentStatus;

    public OrderStatusDTO() {
    }

    public OrderStatusDTO(Order order, String currentStatus) {
        this.order = order;
        this.currentStatus = currentStatus;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getCurrentStatus() {
        return currentStatus;
    }

    public void setCurrentStatus(String currentStatus) {
        this.currentStatus = currentStatus;
    }
}
