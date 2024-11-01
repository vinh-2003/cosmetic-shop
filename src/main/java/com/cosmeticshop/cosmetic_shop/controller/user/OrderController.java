package com.cosmeticshop.cosmetic_shop.controller.user;

import com.cosmeticshop.cosmetic_shop.entity.*;
import com.cosmeticshop.cosmetic_shop.service.*;
import com.cosmeticshop.cosmetic_shop.utils.Utils;
import jakarta.servlet.http.HttpSession;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {
    @Autowired
    private CartService cartService;

    @Autowired
    private ShippingAddressService shippingAddressService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private Utils utils;

    @Autowired
    private OrderStatusService orderStatusService;

    @Autowired
    private ProductService productService;

    @Autowired
    private VoucherService voucherService;

    @PostMapping("/start")
    public String startOrder(HttpSession session, Model model) {
        User user = utils.findUserByUserDetail();
        Cart cart = user.getCart();

        ShippingAddress shippingAddress = shippingAddressService.findFirstByUserOrderByAddressIdAsc(user);

        Order order = (Order) session.getAttribute("order");
        if (order == null) {
            order = orderService.createOrder(cart, shippingAddress);
            session.setAttribute("order", order); // Lưu đơn hàng vào session
        }

        model.addAttribute("address", order.getShippingAddress());
        model.addAttribute("order", order);

        return "previewOrder";
    }

    @GetMapping("/selectAddress")
    public String selectAddress(Model model) {
        User user = utils.findUserByUserDetail();
        List<ShippingAddress> shippingAddresses = user.getShippingAddresses();

        model.addAttribute("addresses", shippingAddresses);

        return "selectShippingAddress";

    }

    @PostMapping("/confirmAddress")
    public String confirmAddress(@RequestParam(value = "addressId", required = false) Long addressId, HttpSession session, Model model) {
        Order order = (Order) session.getAttribute("order");

        if (addressId != null) {
            User user = utils.findUserByUserDetail();
            Cart cart = user.getCart();

            ShippingAddress shippingAddress = shippingAddressService.findById(addressId);

            if (order == null) {
                // Nếu không có đơn hàng trong session, tạo đơn hàng mới
                order = orderService.createOrder(cart, shippingAddress);
                session.setAttribute("order", order);
            } else {
                // Cập nhật địa chỉ giao hàng cho đơn hàng hiện tại
                order.setShippingAddress(shippingAddress);
                orderService.save(order);
            }
        }

        model.addAttribute("address", order.getShippingAddress());
        model.addAttribute("order", order);

        return "previewOrder"; // Trả về trang xem trước đơn hàng với địa chỉ mới
    }

    @PostMapping("/confirmOrder")
    @Transactional
    public String showOrderDetail(HttpSession session, Model model) {
        Order orderSesion = (Order) session.getAttribute("order");
        Order order = orderService.findById(orderSesion.getOrderId());

        // Tạo trạng thái đơn hàng
        OrderStatus orderStatus = new OrderStatus(order, "Chờ xử lý");
        orderStatusService.save(orderStatus);

        for (OrderItem orderItem : order.getOrderItems()) {
            Product product = orderItem.getProduct();
            int orderedQuantity = orderItem.getQuantity();
            int newStockQuantity = product.getStockQuantity() - orderedQuantity;

            // Kiểm tra xem số lượng mới có hợp lệ hay không
            if (newStockQuantity < 0) {
                throw new IllegalArgumentException("Không đủ sản phẩm trong kho");
            }

            // Cập nhật số lượng mới cho sản phẩm
            product.setStockQuantity(newStockQuantity);
            productService.save(product); // Lưu sản phẩm sau khi cập nhật số lượng
        }

        Voucher voucher = order.getVoucher();
        if (voucher != null) {
            voucherService.updateUsageLimit(order.getVoucher());
        }

        // Xóa giỏ hàng của người dùng
        cartService.clearCart(order.getUser());

        // Xóa đơn hàng khỏi session
        session.removeAttribute("order");

        model.addAttribute("order", order);

        return "order-success"; // Trả về trang thành công
    }
}
