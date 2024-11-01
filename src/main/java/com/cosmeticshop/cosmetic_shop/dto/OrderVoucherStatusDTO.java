package com.cosmeticshop.cosmetic_shop.dto;

import com.cosmeticshop.cosmetic_shop.entity.Order;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class OrderVoucherStatusDTO {
    private Long orderId;
    private BigDecimal total;
    private String code;
    private Integer discount;
    private String voucherStatus;

    public OrderVoucherStatusDTO() {
    }

    public OrderVoucherStatusDTO(Long orderId, BigDecimal total, String code, Integer discount, String voucherStatus) {
        this.orderId = orderId;
        this.total = total;
        this.code = code;
        this.discount = discount;
        this.voucherStatus = voucherStatus;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getDiscount() {
        return discount;
    }

    public void setDiscount(Integer discount) {
        this.discount = discount;
    }

    public String getVoucherStatus() {
        return voucherStatus;
    }

    public void setVoucherStatus(String voucherStatus) {
        this.voucherStatus = voucherStatus;
    }
}
