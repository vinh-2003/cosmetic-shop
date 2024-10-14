package com.cosmeticshop.cosmetic_shop.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id")
    private Long orderId;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "total", nullable = false)
    private BigDecimal total;

    @OneToOne
    @JoinColumn(name = "address_id", nullable = false)
    private ShippingAddress shippingAddress;

    @Column(name = "created_at", updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private List<OrderStatus> orderStatuses;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL,
                fetch = FetchType.EAGER)
    private List<OrderItem> orderItems;

    // Constructors
    public Order() {
    }

    public Order(User user, BigDecimal total, OrderStatus currentStatus, ShippingAddress shippingAddress) {
        this.user = user;
        this.total = total;
        this.shippingAddress = shippingAddress;
    }

    // Getters and Setters
    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public ShippingAddress getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(ShippingAddress shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public List<OrderStatus> getOrderStatuses() {
        return orderStatuses;
    }

    public void setOrderStatuses(List<OrderStatus> orderStatuses) {
        this.orderStatuses = orderStatuses;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public void add(OrderStatus orderStatus) {
        if (orderStatuses == null) {
            orderStatuses = new ArrayList<>();
        }
        orderStatuses.add(orderStatus);

        orderStatus.setOrder(this);
    }


}
