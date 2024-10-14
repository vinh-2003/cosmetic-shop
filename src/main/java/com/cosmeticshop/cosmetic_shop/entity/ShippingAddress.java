package com.cosmeticshop.cosmetic_shop.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "shipping_address")
public class ShippingAddress {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "address_id")
    private Long addressId;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(name = "recipient_name", nullable = false)
    private String recipientName;

    @Column(name = "recipient_phone", nullable = false)
    private String recipientPhone;

    @Column(name = "address_line", nullable = false)
    private String addressLine;

    @Column(name = "is_default", nullable = false)
    private Boolean isDefault = false;


    // Constructor
    public ShippingAddress() {}

    public ShippingAddress(User user, String recipientName,
                           String recipientPhone, String addressLine) {
        this.user = user;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.addressLine = addressLine;
    }

    // Getters and Setters

    public Long getAddressId() {
        return addressId;
    }

    public void setAddressId(Long addressId) {
        this.addressId = addressId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getRecipientPhone() {
        return recipientPhone;
    }

    public void setRecipientPhone(String recipientPhone) {
        this.recipientPhone = recipientPhone;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public void setAddressLine(String addressLine) {
        this.addressLine = addressLine;
    }

    public Boolean getDefault() {
        return isDefault;
    }

    public void setDefault(Boolean aDefault) {
        isDefault = aDefault;
    }
}