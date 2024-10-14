package com.cosmeticshop.cosmetic_shop.utils;

import com.cosmeticshop.cosmetic_shop.entity.User;
import com.cosmeticshop.cosmetic_shop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

@Component
public class Utils {

    @Autowired
    private UserService userService;

    public User findUserByUserDetail() {
        // Lấy thông tin UserDetails từ SecurityContext
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = userDetails.getUsername();

        // Tìm người dùng theo username
        return userService.findByUsername(username);
    }
}
