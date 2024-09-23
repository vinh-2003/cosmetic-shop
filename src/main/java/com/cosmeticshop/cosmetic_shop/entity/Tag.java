package com.cosmeticshop.cosmetic_shop.entity;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "tag")
public class Tag {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tag_id")
    private Long tagId;

    @Column(name = "name", nullable = false, unique = true)
    private String name;

    @OneToMany(mappedBy = "tag",
                cascade = {CascadeType.MERGE, CascadeType.PERSIST,
                            CascadeType.DETACH, CascadeType.REFRESH},
                fetch = FetchType.LAZY)
    private List<Product> products;

    // Constructor
    public Tag() {}

    public Tag(String name) {
        this.name = name;
    }

    // Getters and Setters
    public Long getTagId() {
        return tagId;
    }

    public void setTagId(Long tagId) {
        this.tagId = tagId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public void add(Product tempProduct) {
        if (products == null) {
            products = new ArrayList<>();
        }

        products.add(tempProduct);

        tempProduct.setTag(this);
    }
}
