package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Banner;
import com.cosmeticshop.cosmetic_shop.repository.BannerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class BannerServiceImpl implements BannerService {

    @Autowired
    private BannerRepository bannerRepository;

    @Override
    public List<Banner> findAll() {
        return bannerRepository.findAll();
    }

    @Override
    public void save(Banner banner) {
        bannerRepository.save(banner);
    }

    @Override
    public Banner findById(Long id) {

        Optional<Banner> result = bannerRepository.findById(id);

        Banner banner = null;

        if (result.isPresent()) {
            banner = result.get();
        } else {
            throw new RuntimeException("Did not find banner id - " + id);
        }

        return banner;
    }

    @Override
    public void deleteById(Long id) {
        bannerRepository.deleteById(id);
    }
}
