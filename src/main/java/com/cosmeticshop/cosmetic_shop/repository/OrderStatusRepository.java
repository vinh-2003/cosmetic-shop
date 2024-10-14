package com.cosmeticshop.cosmetic_shop.repository;

import com.cosmeticshop.cosmetic_shop.entity.Order;
import com.cosmeticshop.cosmetic_shop.entity.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderStatusRepository extends JpaRepository<OrderStatus, Long> {
    OrderStatus findByOrderAndStatus(Order order, String status);
}
