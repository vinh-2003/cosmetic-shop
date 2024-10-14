package com.cosmeticshop.cosmetic_shop.repository;

import com.cosmeticshop.cosmetic_shop.entity.Order;

public interface CustomOrderRepository {
    Order merge(Order order);
}
