package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.ShippingAddress;
import com.cosmeticshop.cosmetic_shop.entity.User;
import com.cosmeticshop.cosmetic_shop.repository.ShippingAddressRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
public class ShippingAddressServiceImpl implements ShippingAddressService {

    @Autowired
    private ShippingAddressRepository shippingAddressRepository;

    @Override
    public ShippingAddress findById(Long id) {
        Optional<ShippingAddress> result = shippingAddressRepository.findById(id);

        ShippingAddress shippingAddress = null;

        if (result.isPresent()) {
            shippingAddress = result.get();
        } else {
            throw new RuntimeException("Did not find addressId: " + id);
        }

        return shippingAddress;
    }

    @Override
    @Transactional
    public void save(ShippingAddress shippingAddress) {
        shippingAddressRepository.save(shippingAddress);
    }

    @Override
    public ShippingAddress findFirstByUserOrderByAddressIdAsc(User user) {
        return shippingAddressRepository.findFirstByUserOrderByAddressIdAsc(user);
    }


}
