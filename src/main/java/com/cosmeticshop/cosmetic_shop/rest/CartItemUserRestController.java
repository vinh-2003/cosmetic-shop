package com.cosmeticshop.cosmetic_shop.rest;

import com.cosmeticshop.cosmetic_shop.dto.CartItemDTO;
import com.cosmeticshop.cosmetic_shop.entity.Cart;
import com.cosmeticshop.cosmetic_shop.entity.CartItem;
import com.cosmeticshop.cosmetic_shop.entity.Product;
import com.cosmeticshop.cosmetic_shop.service.CartItemService;
import com.cosmeticshop.cosmetic_shop.service.ProductService;
import com.cosmeticshop.cosmetic_shop.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;

@RestController
@RequestMapping("/api/cartItems")
public class CartItemUserRestController {

    @Autowired
    private CartItemService cartItemService;

    @Autowired
    private ProductService productService;

    @Autowired
    private Utils utils;

    @PutMapping
    @Transactional
    public CartItemDTO updateCartItemQuantity(@RequestBody CartItem cartItem) {
        CartItem tempCartItem = cartItemService.findById(cartItem.getCartItemId());
        tempCartItem.setQuantity(cartItem.getQuantity());

        cartItemService.save(tempCartItem);

        Cart cart = tempCartItem.getCart();
        BigDecimal totalOfCartContainThisCartItem = cart.calculateTotal();
        return new CartItemDTO(tempCartItem.getCartItemId(), tempCartItem.getQuantity(), tempCartItem.getPrice(), totalOfCartContainThisCartItem);
    }

    @GetMapping
    public ResponseEntity<Integer> getCartItemQuantityByProductAndCart(@RequestParam("productId") Long productId) {
        Cart cart = utils.findUserByUserDetail().getCart();
        Product product = productService.findById(productId);

        CartItem cartItem = cartItemService.findByCartAndProduct(cart, product);

        if (cartItem != null) {
            return ResponseEntity.ok(cartItem.getQuantity());
        }

        return ResponseEntity.ok(0);
    }
}
