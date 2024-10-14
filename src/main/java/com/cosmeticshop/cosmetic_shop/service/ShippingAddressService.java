package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.ShippingAddress;
import com.cosmeticshop.cosmetic_shop.entity.User;

public interface ShippingAddressService {
    ShippingAddress findById(Long id);
    void save(ShippingAddress shippingAddress);
    ShippingAddress findFirstByUserOrderByAddressIdAsc(User user);
}
