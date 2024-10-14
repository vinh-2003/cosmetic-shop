package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Cart;
import com.cosmeticshop.cosmetic_shop.entity.CartItem;
import com.cosmeticshop.cosmetic_shop.entity.Product;

public interface CartItemService {
    CartItem findByCartAndProduct(Cart cart, Product product);
    void save(CartItem cartItem);
    void delete(CartItem cartItem);
    void updateCartItemsPrice(Product product);
    CartItem findById(Long id);
}
