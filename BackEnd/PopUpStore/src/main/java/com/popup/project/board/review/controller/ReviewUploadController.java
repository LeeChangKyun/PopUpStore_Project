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
        // 다운로드할 파일 객체를 생성
    	File file = new File(UPLOAD_DIR + File.separator + fileName);

        // 파일이 존재하지 않을 경우 예외처리
        if (!file.exists()) {
            throw new IOException("파일을 찾을 수 없습니다.");
        }

        // HTTP 헤더 설정을 위해 HttpHeaders 객체를 생성
        HttpHeaders headers = new HttpHeaders();
        // Content-Disposition 헤더를 설정하여 파일 다운로드시 파일 이름을 지정
        headers.setContentDispositionFormData("attachment", fileName);
        // 파일의 MIME 타입을 설정. MIME 타입을 알 수 없는 경우 기본값으로
        //	'application/octet-stream'을 사용
        headers.setContentType(MediaTypeFactory.getMediaType(fileName)
                                               .orElse(MediaType.APPLICATION_OCTET_STREAM));

        // 파일을 바이트 배열로 읽음
        byte[] data = FileCopyUtils.copyToByteArray(new FileInputStream(file));

        // ResponseEntity 객체를 생성하여 HTTP 응답을 반환
        return ResponseEntity.ok()
                             .headers(headers)
                             .body(data);
    }
}
