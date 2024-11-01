package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Voucher;
import com.cosmeticshop.cosmetic_shop.repository.VoucherRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class VoucherServiceImpl implements VoucherService {
    @Autowired
    private VoucherRepository voucherRepository;

    @Override
    public Voucher findByCode(String code) {
        Voucher voucher = voucherRepository.findByCodeIgnoreCase(code);
        return voucher;
    }

    @Override
    @Transactional
    public void updateUsageLimit(Voucher voucher) {
        voucher.setUsageLimit(voucher.getUsageLimit() - 1);
        voucherRepository.save(voucher);
    }
}
