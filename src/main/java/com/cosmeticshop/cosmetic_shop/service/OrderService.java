package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.dto.OrderStatusDTO;
import com.cosmeticshop.cosmetic_shop.dto.OrderVoucherStatusDTO;
import com.cosmeticshop.cosmetic_shop.entity.Cart;
import com.cosmeticshop.cosmetic_shop.entity.Order;
import com.cosmeticshop.cosmetic_shop.entity.ShippingAddress;
import com.cosmeticshop.cosmetic_shop.entity.User;

import java.util.List;

public interface OrderService {
    void save(Order order);
    Order createOrder(Cart cart, ShippingAddress shippingAddress);
    Order findById(Long id);
    Order mergeOrder(Order order);
    List<Order> findByUser(User user);
    List<Order> findByUserAndStatus(User user, String status);
    List<OrderStatusDTO> findOrdersWithLatestStatus(User user);
    List<OrderStatusDTO> findOrdersWithStatus(User user, String status);
    void deleteById(Long id);
    OrderVoucherStatusDTO setVoucherForOrder(OrderVoucherStatusDTO orderVoucherStatusDTO);
}
