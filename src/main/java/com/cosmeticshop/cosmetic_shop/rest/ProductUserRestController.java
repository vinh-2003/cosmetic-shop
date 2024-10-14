package com.cosmeticshop.cosmetic_shop.rest;

import com.cosmeticshop.cosmetic_shop.entity.Product;
import com.cosmeticshop.cosmetic_shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/products")
public class ProductUserRestController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public ResponseEntity<Integer> getStockQuantityById(@RequestParam("productId") Long productId) {
        Product product = productService.findById(productId);
        int stockQuantity = product.getStockQuantity();
        return ResponseEntity.ok(stockQuantity);
    }
}
