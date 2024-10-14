package com.cosmeticshop.cosmetic_shop.rest;

import com.cosmeticshop.cosmetic_shop.service.OrderService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/orders")
public class OrderUserRestController {

    @Autowired
    private OrderService orderService;

    @DeleteMapping("/{id}")
    @Transactional
    public void deleteOrder(@PathVariable Long id, HttpSession session) {
        session.removeAttribute("order");
        orderService.deleteById(id);
    }
}
