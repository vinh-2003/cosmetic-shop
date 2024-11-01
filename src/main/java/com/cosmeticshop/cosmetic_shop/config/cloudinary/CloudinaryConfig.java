package com.cosmeticshop.cosmetic_shop.config.cloudinary;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class CloudinaryConfig {
    @Bean
    public Cloudinary cloudinary() {
        return new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dhhr73s2r",
                "api_key", "441848116484184",
                "api_secret", "v1lrUTv7ffe4zhh94T5KR4qjl7M",
                "secure", true));
    }
}
