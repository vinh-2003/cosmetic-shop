package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Product;
import org.springframework.data.domain.Page;

import java.util.List;

public interface ProductService {
    List<Product> findAll();
    void save(Product product);
    Product findById(Long id);
    void deleteById(Long id);
    List<Product> findByName(String name);
    public Page<Product> getProductsByPage(int pageNumber, int pageSize);
}
