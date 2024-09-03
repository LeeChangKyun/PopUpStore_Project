package com.popup.project.board.inquiry.service;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class InquiryFileUploadService {

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
        File file = new File(uploadDir, fileName);
        if (file.exists()) {
            if (!file.delete()) {
                throw new IOException("File deletion failed");
            }
        }
    }
}