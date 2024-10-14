package com.cosmeticshop.cosmetic_shop.repository;

import com.cosmeticshop.cosmetic_shop.entity.Order;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class CustomOrderRepositoryImpl implements CustomOrderRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    @Transactional
    public Order merge(Order order) {
        return entityManager.merge(order);
    }
}
