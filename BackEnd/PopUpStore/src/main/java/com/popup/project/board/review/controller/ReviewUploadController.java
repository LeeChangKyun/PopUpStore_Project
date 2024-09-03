package com.popup.project.board.review.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.MediaTypeFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/uploads")
public class ReviewUploadController {

    private static final String UPLOAD_DIR = "C:/review/uploads"; 

    @GetMapping("/download")
    public ResponseEntity<byte[]> downloadFile(@RequestParam("fileName") String fileName) throws IOException {
        File file = new File(UPLOAD_DIR + File.separator + fileName);

        if (!file.exists()) {
            throw new IOException("파일을 찾을 수 없습니다.");
        }

        HttpHeaders headers = new HttpHeaders();
        headers.setContentDispositionFormData("attachment", fileName);
        headers.setContentType(MediaTypeFactory.getMediaType(fileName)
                                               .orElse(MediaType.APPLICATION_OCTET_STREAM));

        byte[] data = FileCopyUtils.copyToByteArray(new FileInputStream(file));

        return ResponseEntity.ok()
                             .headers(headers)
                             .body(data);
    }
}
