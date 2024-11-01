package com.cosmeticshop.cosmetic_shop.rest;

import com.cosmeticshop.cosmetic_shop.dto.OrderVoucherStatusDTO;
import com.cosmeticshop.cosmetic_shop.entity.Order;
import com.cosmeticshop.cosmetic_shop.entity.Voucher;
import com.cosmeticshop.cosmetic_shop.service.OrderService;
import com.cosmeticshop.cosmetic_shop.service.VoucherService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/orders")
public class OrderUserRestController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private VoucherService voucherService;

    @DeleteMapping("/{id}")
    @Transactional
    public void deleteOrder(@PathVariable Long id, HttpSession session) {
        session.removeAttribute("order");
        orderService.deleteById(id);
    }

    @PutMapping()
    public OrderVoucherStatusDTO handleVoucher(@RequestBody OrderVoucherStatusDTO orderVoucherStatusDTO) {

        return orderService.setVoucherForOrder(orderVoucherStatusDTO);
    }
}
