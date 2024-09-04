package com.popup.project.board.review.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class ReviewUploadService {

    private final String UPLOAD_DIR = "C:/review/uploads";

    public ReviewUploadService() {
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            boolean dirCreated = uploadDir.mkdirs();
            if (dirCreated) {
                System.out.println("폴더 생성 성공");
            } else {
                System.out.println("폴더 생성 실패");
            }
        }
    }

    // 허용할 이미지 MIME 타입 목록
    private static final List<String> ALLOWED_MIME_TYPES = List.of("image/jpeg", "image/png", "image/gif", "image/bmp",	"image/JPEG", "image/PNG", "image/GIF", "image/BMP");

    // 파일을 저장하고 저장된 파일의 이름 리스트를 반환
    public List<String> saveFiles(List<MultipartFile> files) throws IOException {
        if (files == null || files.isEmpty()) {
            return Collections.emptyList();
        }

        return files.stream().map(file -> {
            if (file.isEmpty()) {
                return null;
            }

            // 파일의 MIME 타입을 확인하여 이미지 파일만 허용
            String mimeType = file.getContentType();
            if (!ALLOWED_MIME_TYPES.contains(mimeType)) {
                throw new RuntimeException("허용되지 않은 파일 형식입니다: " + mimeType);
            }

            String uniqueFilename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            Path filePath = Paths.get(UPLOAD_DIR, uniqueFilename);
            try {
                Files.write(filePath, file.getBytes());
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 실패", e);
            }
            return uniqueFilename;
        }).filter(Objects::nonNull)
          .collect(Collectors.toList());
    }

    // 파일 삭제
    public void deleteFile(String fileName) {
        if (fileName != null && !fileName.isEmpty()) {
            Path filePath = Paths.get(UPLOAD_DIR, fileName);
            try {
                Files.deleteIfExists(filePath);
                System.out.println("파일이 성공적으로 삭제되었습니다.");
            } catch (IOException e) {
                System.out.println("파일 삭제에 실패하였습니다: " + e.getMessage());
            }
        }
    }
}
