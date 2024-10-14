package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Cart;
import com.cosmeticshop.cosmetic_shop.entity.User;

import java.math.BigDecimal;

public interface CartService {
    void save(Cart cart);
    Cart findByUser(User user);
    void addProductToCart(User user, Long productId, int quantity);
    void removeCartItem(Long cartItemId, Cart cart);
    void clearCart(User user);
}
