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

    public List<String> saveFiles(List<MultipartFile> files) throws IOException {
        if (files == null || files.isEmpty()) {
            return Collections.emptyList();
        }

        return files.stream().map(file -> {
            if (file.isEmpty()) {
                return null;
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

    public void deleteFile(String filename) {
        File file = new File(UPLOAD_DIR + "/" + filename);
        if (file.exists()) {
            file.delete();
        }
    }
}
