package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Category;
import com.cosmeticshop.cosmetic_shop.repository.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoryServiceImpl implements CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Override
    public List<Category> findAll() {
        return categoryRepository.findAll();
    }

    @Override
    public void save(Category category) {
        categoryRepository.save(category);
    }

    @Override
    public Category findById(Long id) {
        Optional<Category> result = categoryRepository.findById(id);

        Category category = null;

        if (result.isPresent()) {
            category = result.get();
        }
        else {
            throw new RuntimeException("Did not find category id - " + id);
        }

        return category;
    }

    @Override
    public void deleteById(Long id) {
        categoryRepository.deleteById(id);
    }
}
