package com.cosmeticshop.cosmetic_shop.controller.admin;

import com.cosmeticshop.cosmetic_shop.entity.Banner;
import com.cosmeticshop.cosmetic_shop.entity.Category;
import com.cosmeticshop.cosmetic_shop.service.BannerService;
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
@RequestMapping("/admin/banners")
public class BannerController {

    @Autowired
    private BannerService bannerService;

    @Autowired
    private CloudinaryService cloudinaryService;

    @GetMapping
    public String getBannerList(Model model) {

        List<Banner> banners = bannerService.findAll();

        model.addAttribute("banners", banners);

        return "admin/admin-banner-list";
    }

    @GetMapping("/showCreateBannerForm")
    public String showCreateBannerForm(Model model) {
        model.addAttribute("banner", new Banner());
        return "admin/banners/create-form";
    }

    @PostMapping("/save")
    @Transactional
    public String saveBanner(@ModelAttribute("banner") Banner banner,
                              @RequestParam("image") MultipartFile file,
                              RedirectAttributes redirectAttributes) {

        if (!file.isEmpty()) {
            try {
                StringBuilder fileNames = new StringBuilder();
                String imageUrl = cloudinaryService.uploadFile(file);
                fileNames.append(file.getOriginalFilename());
                banner.setImageUrl(imageUrl);
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else if (banner.getBannerId() != null) {
            Banner existingBanner = bannerService.findById(banner.getBannerId());
            if (existingBanner != null) {
                banner.setImageUrl(existingBanner.getImageUrl());
            }
        }

        bannerService.save(banner);
        redirectAttributes.addFlashAttribute("message", "thành công!");
        return "redirect:/admin/banners";
    }

    @GetMapping("/showUpdateBannerForm")
    public String showUpdateBannerForm(@RequestParam("bannerId") Long id, Model model) {

        Banner banner = bannerService.findById(id);

        model.addAttribute("banner", banner);

        return "admin/banners/update-form";
    }

    @GetMapping("/delete")
    @Transactional
    public String deleteBanner(@RequestParam("bannerId") Long id) {

        bannerService.deleteById(id);

        return "redirect:/admin/banners";
    }
}
