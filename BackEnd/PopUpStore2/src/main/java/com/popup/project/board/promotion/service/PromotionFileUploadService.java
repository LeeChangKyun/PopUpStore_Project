package com.popup.project.board.promotion.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class PromotionFileUploadService {

    @Value("${file.upload-dir}")
    private String uploadDir;

    // 파일을 저장하고 UUID가 포함된 파일 이름 반환
    public String saveFile(MultipartFile file) throws IOException {
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs(); // 디렉토리가 없으면 생성
        }

        String originalFileName = file.getOriginalFilename();
        String uuidFileName = UUID.randomUUID().toString() + "_" + originalFileName;

        File saveFile = new File(uploadDir, uuidFileName);
        file.transferTo(saveFile);

        return uuidFileName;
    }
    
    // 원본 파일 이름 반환
    public String getOriginalFileName(MultipartFile file) {
        return file.getOriginalFilename();
    }
    
    public void deleteFile(String fileName) throws IOException {
        if (fileName == null || fileName.trim().isEmpty()) {
            throw new IllegalArgumentException("File name cannot be null or empty");
        }

        // 파일의 절대 경로를 계산
        File file = new File(uploadDir, fileName);

        if (!file.exists()) {
            // 파일이 존재하지 않으면 경고 로그를 남기고 예외를 발생시킵니다
            System.err.println("File does not exist: " + file.getAbsolutePath());
            return; // 파일이 없어도 계속 진행할 수 있습니다
        }

        if (!file.delete()) {
            throw new IOException("Failed to delete file: " + file.getAbsolutePath());
        }
    }
}