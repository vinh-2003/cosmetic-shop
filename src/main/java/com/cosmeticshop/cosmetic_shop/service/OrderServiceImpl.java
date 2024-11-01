package com.cosmeticshop.cosmetic_shop.service;

import com.cosmeticshop.cosmetic_shop.dto.OrderStatusDTO;
import com.cosmeticshop.cosmetic_shop.dto.OrderVoucherStatusDTO;
import com.cosmeticshop.cosmetic_shop.entity.*;
import com.cosmeticshop.cosmetic_shop.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderStatusService orderStatusService;

    @Autowired
    private CartService cartService;

    @Autowired
    private CartItemService cartItemService;

    @Autowired
    private VoucherService voucherService;

    @Override
    public void save(Order order) {
        orderRepository.save(order);
    }

    @Override
    @Transactional
    public Order createOrder(Cart cart, ShippingAddress shippingAddress) {
        BigDecimal total = cart.calculateTotal(); // Phương thức này cần được định nghĩa trong Cart

        // Tạo trạng thái đơn hàng mới
        OrderStatus orderStatus = new OrderStatus();
        orderStatus.setStatus("Đang tạo"); // Trạng thái mặc định cho đơn hàng

        // Tạo đơn hàng mới
        Order order = new Order();
        order.setUser(cart.getUser());
        order.setTotal(total);
        order.setShippingAddress(shippingAddress); // Gán địa chỉ giao hàng

        orderStatus.setOrder(order);

        // Tạo danh sách OrderItem từ CartItem
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem cartItem : cart.getCartItems()) {
            OrderItem orderItem = new OrderItem(order, cartItem.getProduct(), cartItem.getQuantity(), cartItem.getPrice());
            orderItems.add(orderItem);
        }
        order.setOrderItems(orderItems); // Gán danh sách OrderItem cho đơn hàng

        order.add(orderStatus);

        return orderRepository.save(order); // Trả về đơn hàng đã tạo
    }

    @Override
    public Order findById(Long id) {
        Optional<Order> result = orderRepository.findById(id);

        Order order = null;
        if (result.isPresent()) {
            order = result.get();
        } else {
            throw new RuntimeException("Did not find order id: " + id);
        }

        return order;
    }

    @Override
    public Order mergeOrder(Order order) {
        return orderRepository.merge(order);
    }

    @Override
    public List<Order> findByUser(User user) {
        return orderRepository.findByUser(user);
    }

    @Override
    public List<Order> findByUserAndStatus(User user, String status) {
        List<Order> orders = orderRepository.findByUser(user);

        List<Order> result = new ArrayList<>();
        for (Order order : orders) {
            OrderStatus orderStatus = orderStatusService.findByOrderAndStatus(order, status);
            if (orderStatus != null) {
                result.add(order);
            }
        }

        return result;
    }

    @Override
    public List<OrderStatusDTO> findOrdersWithLatestStatus(User user) {
        return orderRepository.findOrdersWithLatestStatus(user);
    }

    @Override
    public List<OrderStatusDTO> findOrdersWithStatus(User user, String status) {
        return orderRepository.findOrdersWithStatus(user, status);
    }

    @Override
    @Transactional
    public void deleteById(Long id) {
        orderRepository.deleteById(id);
    }

    @Override
    @Transactional
    public OrderVoucherStatusDTO setVoucherForOrder(OrderVoucherStatusDTO orderVoucherStatusDTO) {
        Order order = orderRepository.findById(orderVoucherStatusDTO.getOrderId()).orElse(null);
        Voucher voucher = voucherService.findByCode(orderVoucherStatusDTO.getCode());

        if (voucher == null) {
            order.setVoucher(null);
            orderRepository.save(order);
            orderVoucherStatusDTO.setTotal(order.getTotal());
            orderVoucherStatusDTO.setDiscount(0);
            orderVoucherStatusDTO.setVoucherStatus("Mã giảm giá không hợp lệ!");
            return orderVoucherStatusDTO;
        } else if (voucher.getUsageLimit() == 0) {
            order.setVoucher(null);
            orderRepository.save(order);
            orderVoucherStatusDTO.setTotal(order.getTotal());
            orderVoucherStatusDTO.setDiscount(0);
            orderVoucherStatusDTO.setVoucherStatus("Mã giảm giá hết lượt sử dụng!");
            return orderVoucherStatusDTO;
        } else if (order.getTotal().compareTo(voucher.getMinPurchase()) < 0) {
            order.setVoucher(null);
            orderRepository.save(order);
            orderVoucherStatusDTO.setTotal(order.getTotal());
            orderVoucherStatusDTO.setDiscount(0);
            orderVoucherStatusDTO.setVoucherStatus("Giá trị đơn hàng không đủ để sử dụng mã này!");
            return orderVoucherStatusDTO;
        } else {
            order.setVoucher(voucher);
            orderRepository.save(order);
            orderVoucherStatusDTO.setTotal(order.getTotal());
            orderVoucherStatusDTO.setDiscount(voucher.getDiscount());
            orderVoucherStatusDTO.setVoucherStatus("Đã áp dụng giảm giá " + voucher.getDiscount() + "đ");
            return orderVoucherStatusDTO;
        }
    }
}
