package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Order;
import com.cosmeticshop.cosmetic_shop.entity.OrderStatus;
import com.cosmeticshop.cosmetic_shop.repository.OrderStatusRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderStatusServiceImpl implements OrderStatusService {
    @Autowired
    private OrderStatusRepository orderStatusRepository;

    @Override
    public void save(OrderStatus orderStatus) {
        orderStatusRepository.save(orderStatus);
    }

    @Override
    public OrderStatus findByOrderAndStatus(Order order, String status) {
        return orderStatusRepository.findByOrderAndStatus(order, status);
    }
}
