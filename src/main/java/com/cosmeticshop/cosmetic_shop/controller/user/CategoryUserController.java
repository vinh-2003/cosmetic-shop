package com.cosmeticshop.cosmetic_shop.controller.user;

import com.cosmeticshop.cosmetic_shop.entity.Category;
import com.cosmeticshop.cosmetic_shop.entity.Product;
import com.cosmeticshop.cosmetic_shop.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/categories")
public class CategoryUserController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("/{id}")
    public String getProductsByCategoryId(@PathVariable("id") Long id, Model model) {
        Category category = categoryService.findById(id);

        List<Category> categories = categoryService.findAll();
        List<Product> products = category.getProducts();

        model.addAttribute("category", category);
        model.addAttribute("categories", categories);
        model.addAttribute("products", products);

        return "category-products";
    }

}
