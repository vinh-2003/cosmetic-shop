package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Cart;
import com.cosmeticshop.cosmetic_shop.entity.CartItem;
import com.cosmeticshop.cosmetic_shop.entity.Product;
import com.cosmeticshop.cosmetic_shop.repository.CartItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class CartItemServiceImpl implements CartItemService {

    @Autowired
    private CartItemRepository cartItemRepository;

    @Override
    public CartItem findByCartAndProduct(Cart cart, Product product) {
        return cartItemRepository.findByCartAndProduct(cart, product).orElse(null);
    }

    @Override
    public void save(CartItem cartItem) {
        cartItemRepository.save(cartItem);
    }

    @Override
    public void delete(CartItem cartItem) {
        cartItemRepository.delete(cartItem);
    }

    @Override
    @Transactional
    public void updateCartItemsPrice(Product product) {
        // Tìm tất cả các CartItem có liên quan đến sản phẩm
        List<CartItem> cartItems = cartItemRepository.findByProduct(product);

        // Tính giá mới sau khi áp dụng giảm giá
        BigDecimal newDiscountedPrice = product.getPrice().multiply(BigDecimal.valueOf(100).subtract(product.getDiscountPercentage())).divide(BigDecimal.valueOf(100));

        // Cập nhật giá mới cho từng CartItem
        for (CartItem cartItem : cartItems) {
            cartItem.setPrice(newDiscountedPrice);
            cartItemRepository.save(cartItem);  // Lưu thay đổi vào cơ sở dữ liệu
        }
    }

    @Override
    public CartItem findById(Long id) {
        Optional<CartItem> result = cartItemRepository.findById(id);

        CartItem cartItem = null;

        if (result.isPresent()) {
            cartItem = result.get();
        } else {
            throw new RuntimeException("Không tìm thấy cartItem id: " + id);
        }

        return cartItem;
    }
}
