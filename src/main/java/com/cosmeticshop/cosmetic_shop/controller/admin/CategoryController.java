package com.cosmeticshop.cosmetic_shop.controller.admin;

import com.cosmeticshop.cosmetic_shop.entity.Category;
import com.cosmeticshop.cosmetic_shop.entity.Product;
import com.cosmeticshop.cosmetic_shop.entity.Tag;
import com.cosmeticshop.cosmetic_shop.service.CategoryService;
import com.cosmeticshop.cosmetic_shop.service.CloudinaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CloudinaryService cloudinaryService;

    @GetMapping
    public String getCategoryList(Model model) {

        List<Category> categories = categoryService.findAll();

        model.addAttribute("categories", categories);

        return "admin/admin-category-list";
    }

    @GetMapping("/showCreateCategoryForm")
    public String showCreateCategoryForm(Model model) {
        model.addAttribute("category", new Category());
        return "admin/categories/create-form";
    }

    @PostMapping("/save")
    @Transactional
    public String saveBanner(@ModelAttribute("category") Category category,
                              @RequestParam("image") MultipartFile file,
                              RedirectAttributes redirectAttributes) {

        if (!file.isEmpty()) {
            try {
                StringBuilder fileNames = new StringBuilder();
                String imageUrl = cloudinaryService.uploadFile(file);
                fileNames.append(file.getOriginalFilename());
                // Lưu đường dẫn của file vào product
                category.setImageUrl(imageUrl);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else if (category.getCategoryId() != null) {
            Category existingCategory = categoryService.findById(category.getCategoryId());
            if (existingCategory != null) {
                category.setImageUrl(existingCategory.getImageUrl());
            }
        }
        // Lưu product vào cơ sở dữ liệu
        categoryService.save(category);
        redirectAttributes.addFlashAttribute("message", "thành công!");
        return "redirect:/admin/categories";
    }

    @GetMapping("/showUpdateCategoryForm")
    public String showUpdateCategoryForm(@RequestParam("categoryId") Long id, Model model) {

        Category category = categoryService.findById(id);

        model.addAttribute("category", category);

        return "admin/categories/update-form";
    }

    @GetMapping("/delete")
    @Transactional
    public String deleteCategory(@RequestParam("categoryId") Long id) {

        categoryService.deleteById(id);

        return "redirect:/admin/categories";
    }
}
