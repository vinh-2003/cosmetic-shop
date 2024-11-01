package com.cosmeticshop.cosmetic_shop.controller.admin;

import com.cosmeticshop.cosmetic_shop.entity.Category;
import com.cosmeticshop.cosmetic_shop.entity.Product;
import com.cosmeticshop.cosmetic_shop.entity.Tag;
import com.cosmeticshop.cosmetic_shop.service.*;
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
@RequestMapping("/admin/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CartItemService cartItemService;

    @Autowired
    private TagService tagService;

    @Autowired
    private CloudinaryService cloudinaryService;

    @GetMapping
    public String getProductList(Model model) {
        List<Product> products = productService.findAll();
        model.addAttribute("products", products);
        return "admin/admin-product-list";
    }

    @GetMapping("/showCreateProductForm")
    public String showCreateProductForm(Model model) {
        List<Category> categories = categoryService.findAll();
        List<Tag> tags = tagService.finddAll();
        model.addAttribute("product", new Product());
        model.addAttribute("categories", categories);
        model.addAttribute("tags", tags);
        return "admin/products/create-form";
    }

    @PostMapping("/save")
    @Transactional
    public String saveProduct(@ModelAttribute("product") Product product,
                               @RequestParam("image") MultipartFile file,
                               RedirectAttributes redirectAttributes) {

        if (!file.isEmpty()) {
            try {
                StringBuilder fileNames = new StringBuilder();
                String imageUrl = cloudinaryService.uploadFile(file);
                fileNames.append(file.getOriginalFilename());
                // Lưu đường dẫn của file vào product
                product.setImageUrl(imageUrl);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else if (product.getProductId() != null) {
            Product existingProduct = productService.findById(product.getProductId());
            if (existingProduct != null) {
                product.setImageUrl(existingProduct.getImageUrl());
            }
        }
        // Lưu product vào cơ sở dữ liệu
        productService.save(product);

        // Sau khi lưu sản phẩm, cập nhật các CartItem liên quan
        cartItemService.updateCartItemsPrice(product);

        redirectAttributes.addFlashAttribute("message", "thành công!");
        return "redirect:/admin/products";
    }

    @GetMapping("/showUpdateProductForm")
    public String showUpdateProductForm(@RequestParam("productId") Long id, Model model) {

        Product product = productService.findById(id);

        List<Category> categories = categoryService.findAll();
        List<Tag> tags = tagService.finddAll();

        model.addAttribute("categories", categories);
        model.addAttribute("tags", tags);

        model.addAttribute("product", product);

        return "admin/products/update-form";
    }

    @GetMapping("/delete")
    @Transactional
    public String deleteProduct(@RequestParam("productId") Long id) {

        productService.deleteById(id);

        return "redirect:/admin/products";
    }
}
