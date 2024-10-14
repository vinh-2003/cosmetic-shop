package com.cosmeticshop.cosmetic_shop.controller.user;

import com.cosmeticshop.cosmetic_shop.dto.OrderStatusDTO;
import com.cosmeticshop.cosmetic_shop.entity.Category;
import com.cosmeticshop.cosmetic_shop.entity.Order;
import com.cosmeticshop.cosmetic_shop.entity.ShippingAddress;
import com.cosmeticshop.cosmetic_shop.entity.User;
import com.cosmeticshop.cosmetic_shop.service.CategoryService;
import com.cosmeticshop.cosmetic_shop.service.OrderService;
import com.cosmeticshop.cosmetic_shop.service.ShippingAddressService;
import com.cosmeticshop.cosmetic_shop.service.UserService;
import com.cosmeticshop.cosmetic_shop.utils.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private ShippingAddressService shippingAddressService;

    @Autowired
    private Utils utils;

    @Autowired
    private OrderService orderService;

    @GetMapping("/account")
    public String getUserAccount(Model model) {

        List<Category> categories = categoryService.findAll();

        User user = utils.findUserByUserDetail();

        model.addAttribute("categories", categories);
        model.addAttribute("user", user);

        return "account";
    }

    @PostMapping("/save")
    public String saveUser(@ModelAttribute("user") User user, Model model) {
        userService.save(user);
        model.addAttribute("user", user);
        return "redirect:/user/account";
    }

    @GetMapping("/address/showFormCreateAddress")
    public String showFormCreateAddress(Model model) {
        List<Category> categories = categoryService.findAll();

        model.addAttribute("categories", categories);
        model.addAttribute("address", new ShippingAddress());
        return "address-create";
    }

    @GetMapping("/address")
    public String getAddressList(Model model) {
        List<Category> categories = categoryService.findAll();

//        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        String username = userDetails.getUsername();
//        User user = userService.findByUsername(username);

        User user = utils.findUserByUserDetail();

        List<ShippingAddress> shippingAddresses = user.getShippingAddresses();

        model.addAttribute("categories", categories);
        model.addAttribute("addresses", shippingAddresses);

        return "address-list";
    }

    @GetMapping("/address/{addressId}")
    public String getAddressDetail(@PathVariable("addressId") Long id, Model model) {

        List<Category> categories = categoryService.findAll();

        ShippingAddress shippingAddress = shippingAddressService.findById(id);

        model.addAttribute("categories", categories);
        model.addAttribute("address", shippingAddress);

        return "address-detail";
    }

    @PostMapping("/address/save")
    public String updateAddress(@ModelAttribute("address") ShippingAddress shippingAddress) {
        User user = utils.findUserByUserDetail();
        shippingAddress.setUser(user);
        shippingAddressService.save(shippingAddress);

        return "redirect:/user/address";
    }

    @GetMapping("/orders")
    private String getOrderList(@RequestParam(value = "status", required = false) String status, Model model) {
        User user = utils.findUserByUserDetail();

        List<OrderStatusDTO> orderAndStatuses = null;

        if (status == null) {
            orderAndStatuses = orderService.findOrdersWithLatestStatus(user);
        } else {
            orderAndStatuses = orderService.findOrdersWithStatus(user, status);
        }

        model.addAttribute("orderAndStatuses", orderAndStatuses);

        return "order-list";
    }
}
