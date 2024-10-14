package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.User;

public interface UserService {
    void registerUser(User user);
    User findByUsername(String username);
    void save(User user);
}
