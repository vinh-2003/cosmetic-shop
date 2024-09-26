package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Banner;

import java.util.List;

public interface BannerService {
    List<Banner> findAll();
    void save(Banner banner);
    Banner findById(Long id);
    void deleteById(Long id);
}
