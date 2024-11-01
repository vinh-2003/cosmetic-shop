package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.entity.Voucher;

public interface VoucherService {
    Voucher findByCode(String code);
    void updateUsageLimit(Voucher voucher);
}
