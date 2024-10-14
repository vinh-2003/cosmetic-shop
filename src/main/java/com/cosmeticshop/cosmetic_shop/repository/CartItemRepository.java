package com.cosmeticshop.cosmetic_shop.repository;

import com.cosmeticshop.cosmetic_shop.entity.Cart;
import com.cosmeticshop.cosmetic_shop.entity.CartItem;
import com.cosmeticshop.cosmetic_shop.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    Optional<CartItem> findByCartAndProduct(Cart cart, Product product);
    List<CartItem> findByProduct(Product product);
}
