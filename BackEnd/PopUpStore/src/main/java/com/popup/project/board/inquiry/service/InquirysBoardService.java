package com.popup.project.board.inquiry.service;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.popup.project.board.inquiry.dto.InquiryBoardService;
import com.popup.project.board.inquiry.dto.InquiryDTO;
import com.popup.project.board.inquiry.dto.InquirySimpleBbsDTO;

@Service
public class InquirysBoardService {

    @Autowired
    private InquiryBoardService dao;
    
    @Autowired
    private InquiryFileUploadService fileUploadService;
    
    public ArrayList<InquirySimpleBbsDTO> getBoardList(InquiryDTO inquiryDTO) {
        return dao.listPage(inquiryDTO);
    }
    
    public int getTotalCount(InquiryDTO inquiryDTO) {
        return dao.getTotalCount(inquiryDTO);
    }

    public InquirySimpleBbsDTO getBoardView(InquirySimpleBbsDTO simplebbsDTO) {
        return dao.view(simplebbsDTO);
    }
    
    public int writePost(InquirySimpleBbsDTO dto, MultipartFile inquiryOfile, MultipartFile inquirySfile) throws IOException {
        if (inquiryOfile != null && !inquiryOfile.isEmpty()) {
            String originalOfileName = fileUploadService.getOriginalFileName(inquiryOfile);
            String savedOfileName = fileUploadService.saveFile(inquiryOfile);
            dto.setInquiry_ofile(originalOfileName);
            dto.setInquiry_sfile(savedOfileName);
        }

        if (inquirySfile != null && !inquirySfile.isEmpty()) {
            String savedSfileName = fileUploadService.saveFile(inquirySfile);
            dto.setInquiry_sfile(savedSfileName);
        }

        return dao.write(dto);
    }

    
    public int editPost(InquirySimpleBbsDTO dto, MultipartFile inquiryOfile, String prevOfile) throws IOException {
        // 새 파일 저장
        if (inquiryOfile != null && !inquiryOfile.isEmpty()) {
            // 기존 파일 삭제 (이전 파일이 있는 경우)
            if (prevOfile != null && !prevOfile.trim().isEmpty()) {
                try {
                    fileUploadService.deleteFile(prevOfile);
                } catch (IllegalArgumentException e) {
                    // 예외 처리: 로그를 남기거나 다른 처리를 수행
                    System.err.println("Error deleting file: " + e.getMessage());
                    // 필요 시, 예외를 다시 던지거나 적절한 조치를 취할 수 있습니다.
                    throw new IOException("Failed to delete previous file: " + prevOfile, e);
                }
            }

            // 새 파일 저장
            String savedFileName = fileUploadService.saveFile(inquiryOfile);
            dto.setInquiry_ofile(fileUploadService.getOriginalFileName(inquiryOfile));
            dto.setInquiry_sfile(savedFileName);
        } else {
            // 파일이 없으면 이전 파일 이름을 그대로 사용
            dto.setInquiry_ofile(prevOfile);
        }

        // 게시글 업데이트 로직
        return dao.edit(dto);
    }
    


    public int inquirydeletePost(String inquiryNum) {
        return dao.inquiryDelete(inquiryNum);
    }

    public void incrementVisitCount(String inquiryNum) {
        dao.incrementVisitCount(inquiryNum);
    }

    public void incrementDownCount(String inquiryNum) {
        dao.incrementDownCount(inquiryNum);
    }

	
}