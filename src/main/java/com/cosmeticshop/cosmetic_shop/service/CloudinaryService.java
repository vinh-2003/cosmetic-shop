package com.cosmeticshop.cosmetic_shop.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public interface CloudinaryService {
    String uploadFile(MultipartFile file) throws IOException;
}
