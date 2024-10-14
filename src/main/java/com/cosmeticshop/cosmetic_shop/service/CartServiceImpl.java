package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Cart;
import com.cosmeticshop.cosmetic_shop.entity.CartItem;
import com.cosmeticshop.cosmetic_shop.entity.Product;
import com.cosmeticshop.cosmetic_shop.entity.User;
import com.cosmeticshop.cosmetic_shop.repository.CartRepository;
import com.cosmeticshop.cosmetic_shop.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@Service
public class CartServiceImpl implements CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductService productService;

    @Autowired
    private CartItemService cartItemService;

    @Override
    public void save(Cart cart) {
        cartRepository.save(cart);
    }

    @Override
    public Cart findByUser(User user) {
        return cartRepository.findByUser(user).orElse(null);
    }

    @Override
    public void addProductToCart(User user, Long productId, int quantity) {
        // Tìm giỏ hàng của người dùng hiện tại
        Cart cart = cartRepository.findByUser(user)
                .orElseThrow(() -> new RuntimeException("Cart not found"));

        // Lấy sản phẩm từ kho
        Product product = productService.findById(productId);

        // Tìm CartItem dựa trên giỏ hàng và sản phẩm
        CartItem cartItem = cartItemService.findByCartAndProduct(cart, product);

        if (cartItem != null) {
            // Nếu sản phẩm đã có trong giỏ, tăng số lượng
            cartItem.setQuantity(cartItem.getQuantity() + quantity);
        } else {
            // Nếu chưa có, tạo CartItem mới và thêm vào giỏ hàng
            cartItem = new CartItem(cart, product, quantity, product.getPrice().multiply(BigDecimal.valueOf(100).subtract(product.getDiscountPercentage())).divide(BigDecimal.valueOf(100)));
            cart.add(cartItem);
        }

        // Lưu giỏ hàng và CartItem
        cartRepository.save(cart);
    }

    @Override
    @Transactional
    public void removeCartItem(Long cartItemId, Cart cart) {
        CartItem cartItemToRemove = cart.getCartItems().stream()
                .filter(item -> item.getCartItemId().equals(cartItemId))
                .findFirst()
                .orElseThrow(() -> new RuntimeException("CartItem not found"));

        cart.getCartItems().remove(cartItemToRemove);
        cartItemService.delete(cartItemToRemove);
    }

    @Override
    @Transactional
    public void clearCart(User user) {
        Cart cart = cartRepository.findByUser(user)
                .orElseThrow(() -> new RuntimeException("Cart not found"));
        for (CartItem cartItem : cart.getCartItems()) {
            cartItemService.delete(cartItem);
        }
        cart.getCartItems().clear();
        cartRepository.save(cart);
    }

}
