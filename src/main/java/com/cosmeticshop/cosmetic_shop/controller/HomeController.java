package com.cosmeticshop.cosmetic_shop.controller;

import com.cosmeticshop.cosmetic_shop.entity.Banner;
import com.cosmeticshop.cosmetic_shop.entity.Category;
import com.cosmeticshop.cosmetic_shop.entity.Product;
import com.cosmeticshop.cosmetic_shop.service.BannerService;
import com.cosmeticshop.cosmetic_shop.service.CategoryService;
import com.cosmeticshop.cosmetic_shop.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class HomeController {

    @Autowired
    private BannerService bannerService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public String redirectToHome() {
        return "redirect:/home";  // Chuyển hướng đến trang home
    }

    @GetMapping("/home")
    public String showHomePage(Model model) {

        List<Banner> banners = bannerService.findAll();
        List<Category> categories = categoryService.findAll();
        List<Product> products = productService.findAll();

        model.addAttribute("banners", banners);
        model.addAttribute("categories", categories);
        model.addAttribute("products", products);

        return "home";
    }
}
