package com.cosmeticshop.cosmetic_shop.repository;

import com.cosmeticshop.cosmetic_shop.entity.Banner;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface BannerRepository extends JpaRepository<Banner, Long> {
}
