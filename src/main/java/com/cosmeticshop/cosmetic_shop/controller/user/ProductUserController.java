package com.cosmeticshop.cosmetic_shop.controller.user;

import com.cosmeticshop.cosmetic_shop.entity.Category;
import com.cosmeticshop.cosmetic_shop.entity.Product;
import com.cosmeticshop.cosmetic_shop.service.CategoryService;
import com.cosmeticshop.cosmetic_shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductUserController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @GetMapping
    public String getProductsByName(@RequestParam("name") String name, Model model) {
        List<Product> products = productService.findByName(name);
        List<Category> categories = categoryService.findAll();

        model.addAttribute("products", products);
        model.addAttribute("categories", categories);

        return "products";
    }

    @GetMapping("/{productId}")
    public String getProductById(@PathVariable("productId") Long id, Model model) {
        Product product = productService.findById(id);
        List<Category> categories = categoryService.findAll();

        model.addAttribute("product", product);
        model.addAttribute("categories", categories);

        return "product-detail";
    }

}
