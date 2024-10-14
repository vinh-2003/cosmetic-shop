package com.cosmeticshop.cosmetic_shop.repository;

import com.cosmeticshop.cosmetic_shop.entity.ShippingAddress;
import com.cosmeticshop.cosmetic_shop.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ShippingAddressRepository extends JpaRepository<ShippingAddress, Long> {
    ShippingAddress findFirstByUserOrderByAddressIdAsc(User user);
}
