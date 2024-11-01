package com.cosmeticshop.cosmetic_shop.repository;

import com.cosmeticshop.cosmetic_shop.dto.OrderStatusDTO;
import com.cosmeticshop.cosmetic_shop.entity.Order;
import com.cosmeticshop.cosmetic_shop.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long>, CustomOrderRepository {
    List<Order> findByUser(User user);
    @Query("SELECT new com.cosmeticshop.cosmetic_shop.dto.OrderStatusDTO(o, os.status) " +
            "FROM Order o LEFT JOIN o.orderStatuses os " +
            "WHERE o.user = :user " +
            "AND os.status <> 'ĐANG TẠO' "+
            "AND os.changedAt = (SELECT MAX(os2.changedAt) FROM OrderStatus os2 WHERE os2.order.orderId = o.orderId) " +
            "ORDER BY o.createdAt desc")
    List<OrderStatusDTO> findOrdersWithLatestStatus(@Param("user") User user);

    @Query("SELECT new com.cosmeticshop.cosmetic_shop.dto.OrderStatusDTO(o, os.status) " +
            "FROM Order o LEFT JOIN o.orderStatuses os " +
            "WHERE o.user = :user " +
            "AND os.status = :status " +
            "AND os.changedAt = (SELECT MAX(os2.changedAt) FROM OrderStatus os2 WHERE os2.order.orderId = o.orderId) " +
            "ORDER BY o.createdAt desc")
    List<OrderStatusDTO> findOrdersWithStatus(@Param("user") User user, @Param("status") String status);
}
