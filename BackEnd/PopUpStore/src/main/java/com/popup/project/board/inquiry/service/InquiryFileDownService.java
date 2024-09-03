package com.popup.project.board.inquiry.service;

import java.io.File;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class InquiryFileDownService {

    @Value("${file.upload-dir}")
    private String uploadDir;
    
    public ResponseEntity<Resource> downloadFile(String inquiryOfile, String inquirySfile) {
        try {
            File file = new File(uploadDir + File.separator + inquirySfile);
            
            if (!file.exists()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }

            Resource resource = new FileSystemResource(file);

            // 파일 이름을 URL 인코딩합니다.
            String encodedFileName = URLEncoder.encode(inquiryOfile, StandardCharsets.UTF_8.toString())
                                           .replace("+", "%20"); // 공백을 %20으로 변환

            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"");

            return ResponseEntity.ok()
                    .headers(headers)
                    .contentLength(file.length())
                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
                    .body(resource);

        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }
}