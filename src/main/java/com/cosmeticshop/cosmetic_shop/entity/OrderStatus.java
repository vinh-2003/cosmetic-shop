package com.cosmeticshop.cosmetic_shop.entity;

import jakarta.persistence.*;
import java.util.Date;

@Entity
@Table(name = "order_status")
public class OrderStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "status_id")
    private Long statusId;

    @ManyToOne
    @JoinColumn(name = "order_id")
    private Order order;

    @Column(name = "status", nullable = false)
    private String status;

    @Column(name = "changed_at", updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date changedAt;

    // Constructors
    public OrderStatus() {
    }

    public OrderStatus(Order order, String status) {
        this.order = order;
        this.status = status;
    }

    // Getters and Setters
    public Long getStatusId() {
        return statusId;
    }

    public void setStatusId(Long statusId) {
        this.statusId = statusId;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getChangedAt() {
        return changedAt;
    }
}
