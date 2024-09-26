package com.cosmeticshop.cosmetic_shop.entity;

import jakarta.persistence.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Entity
@Table(name = "banner")
public class Banner {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "banner_id")
    private Long bannerId;

    @Column(name = "image_url", nullable = false)
    private String imageUrl;

    @Column(name = "link")
    private String link;

    @Column(name = "start_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date startDate;

    @Column(name = "end_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private Date endDate;

    @Column(name = "created_at", updatable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdAt;

    // Constructor
    public Banner() {}

    public Banner(String imageUrl, String link, Date startDate, Date endDate) {
        this.imageUrl = imageUrl;
        this.link = link;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    // Getters và Setters
    public Long getBannerId() {
        return bannerId;
    }

    public void setBannerId(Long bannerId) {
        this.bannerId = bannerId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Date getCreatedAt() {
        return createdAt;
    }
}

