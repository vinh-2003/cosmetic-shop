package com.cosmeticshop.cosmetic_shop.entity;

import jakarta.persistence.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "cart")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cart_id")
    private Long cartId;

    @OneToOne(cascade = {CascadeType.MERGE, CascadeType.PERSIST,
                        CascadeType.DETACH, CascadeType.REFRESH})
    @JoinColumn(name = "user_id", nullable = false, unique = true)
    private User user;

    @Column(name = "created_at", updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    @OneToMany(mappedBy = "cart", cascade = CascadeType.ALL)
    private List<CartItem> cartItems;

    //Constructor

    public Cart() {
    }

    public Cart(User user) {
        this.user = user;
    }

    //Getters and Setters

    public Long getCartId() {
        return cartId;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createAt) {
        this.createdAt = createdAt;
    }

    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = cartItems;
    }

    public void add(CartItem tempCartItem) {
        if (cartItems == null) {
            cartItems = new ArrayList<>();
        }

        cartItems.add(tempCartItem);

        tempCartItem.setCart(this);
    }

    public BigDecimal calculateTotal() {
        BigDecimal total = BigDecimal.ZERO;

        for (CartItem cartItem : cartItems) {
            // Giả sử price là giá sản phẩm và quantity là số lượng
            BigDecimal itemTotal = cartItem.getPrice().multiply(new BigDecimal(cartItem.getQuantity()));
            total = total.add(itemTotal);
        }

        return total;
    }
}
