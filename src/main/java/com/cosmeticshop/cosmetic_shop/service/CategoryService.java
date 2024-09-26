package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Category;

import java.util.List;

public interface CategoryService {
    List<Category> findAll();
    void save(Category category);
    Category findById(Long id);
    void deleteById(Long id);
}
