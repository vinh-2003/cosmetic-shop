package com.cosmeticshop.cosmetic_shop.rest;

import com.cosmeticshop.cosmetic_shop.entity.User;
import com.cosmeticshop.cosmetic_shop.service.CartService;
import com.cosmeticshop.cosmetic_shop.service.UserService;
import com.cosmeticshop.cosmetic_shop.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;

@RestController
@RequestMapping("/api/cart")
public class CartRestController {

    @Autowired
    private CartService cartService;

    @Autowired
    private UserService userService;

    @Autowired
    private Utils utils;

    @PostMapping("/add")
    public ResponseEntity<String> addProductToCart(@RequestParam("productId") Long productId,
                                                   @RequestParam("quantity") int quantity) {
        System.out.println("id: " + productId + ", quantity: " + quantity);
        try {
            // Lấy thông tin người dùng hiện tại
            User user = utils.findUserByUserDetail();

            // Thêm sản phẩm vào giỏ hàng
            cartService.addProductToCart(user, productId, quantity);

            // Trả về kết quả thành công dưới dạng JSON
            return ResponseEntity.ok("Sản phẩm đã được thêm vào giỏ hàng thành công!");
        } catch (Exception e) {
            // Trả về lỗi nếu có vấn đề xảy ra
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Thêm sản phẩm thất bại!");
        }
    }
}
