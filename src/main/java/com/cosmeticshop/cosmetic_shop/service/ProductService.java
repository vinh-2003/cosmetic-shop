package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Product;

import java.util.List;

public interface ProductService {
    List<Product> findAll();
    void save(Product product);
}
