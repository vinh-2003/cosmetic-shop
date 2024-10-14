package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Order;
import com.cosmeticshop.cosmetic_shop.entity.OrderStatus;

public interface OrderStatusService {
    void save(OrderStatus orderStatus);
    OrderStatus findByOrderAndStatus(Order order, String status);
}
