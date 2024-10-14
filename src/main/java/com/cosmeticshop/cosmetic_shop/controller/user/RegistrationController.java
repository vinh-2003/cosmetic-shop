package com.cosmeticshop.cosmetic_shop.controller.user;

import com.cosmeticshop.cosmetic_shop.entity.User;
import com.cosmeticshop.cosmetic_shop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/register")
public class RegistrationController {

    @Autowired
    private UserService userService;

    @GetMapping
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new User());

        return "register";
    }

    @PostMapping
    public String registerUser(@ModelAttribute("usesr") User user) {
        userService.registerUser(user);

        return "redirect:/login";
    }

}
