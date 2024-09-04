package com.popup.project.board.promotion.service;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.popup.project.board.promotion.dto.PromotionBoardDTO;
import com.popup.project.board.promotion.dto.PromotionParameterDTO;

import jakarta.servlet.http.HttpServletRequest;

@Service
public class PromotionBoardService {

    @Autowired
    private PromotionBoardMapper dao;
    
    @Autowired
    private PromotionFileUploadService fileUploadService;
    
    public ArrayList<PromotionBoardDTO> getBoardList(PromotionParameterDTO parameterDTO) {
        return dao.listPage(parameterDTO);
    }
    
    public int getTotalCount(PromotionParameterDTO parameterDTO) {
        return dao.getTotalCount(parameterDTO);
    }

    public PromotionBoardDTO getBoardView(PromotionBoardDTO simplebbsDTO) {
        return dao.view(simplebbsDTO);
    }
    
    public int writePost(PromotionBoardDTO dto, MultipartFile promotionOfile, MultipartFile promotionSfile) throws IOException {
        if (promotionOfile != null && !promotionOfile.isEmpty()) {
            String originalOfileName = fileUploadService.getOriginalFileName(promotionOfile);
            String savedOfileName = fileUploadService.saveFile(promotionOfile);
            dto.setPromotion_ofile(originalOfileName);
            dto.setPromotion_sfile(savedOfileName);
        }

        if (promotionSfile != null && !promotionSfile.isEmpty()) {
            String savedSfileName = fileUploadService.saveFile(promotionSfile);
            dto.setPromotion_sfile(savedSfileName);
        }

        return dao.write(dto);
    }

    public int editPost(PromotionBoardDTO dto, MultipartFile promotionOfile, String prevOfile, HttpServletRequest request) throws IOException {
        // 새 파일이 존재할 경우
        if (promotionOfile != null && !promotionOfile.isEmpty()) {
            // 이전 파일 삭제 (이전 파일이 있는 경우)
            if (prevOfile != null && !prevOfile.trim().isEmpty()) {
                try {
                    fileUploadService.deleteFile(prevOfile);
                } catch (IllegalArgumentException e) {
                    System.err.println("Error deleting file: " + e.getMessage());
                    throw new IOException("Failed to delete previous file: " + prevOfile, e);
                }
            }

            // 새 파일 저장
            String savedFileName = fileUploadService.saveFile(promotionOfile);
            dto.setPromotion_ofile(fileUploadService.getOriginalFileName(promotionOfile));
            dto.setPromotion_sfile(savedFileName);
        } else {
            // 새 파일이 없으면 기존 파일 유지
            dto.setPromotion_ofile(prevOfile);
        }

        // 추가적인 request 기반 로직이 필요하다면 여기에서 수행할 수 있습니다.
        // 예: request에서 파라미터를 읽어와서 처리

        // 게시물 업데이트
        return dao.edit(dto);
    }

    public int promotiondeletePost(String promotionNum) {
        // 게시물 삭제 로직을 구현합니다.
        // 먼저 파일 삭제 로직이 필요할 경우 구현합니다.

//        // 파일 삭제 (Optional: 파일 저장 방식에 따라 필요할 수도 있음)
//        PromotionBoardDTO dto = dao.view(new PromotionBoardDTO());
//        if (dto.getPromotion_sfile() != null && !dto.getPromotion_sfile().isEmpty()) {
//            try {
//                fileUploadService.deleteFile(dto.getPromotion_sfile());
//            } catch (Exception e) {
//                System.err.println("Error deleting associated files: " + e.getMessage());
//            }
//        }

        // DB에서 게시물 삭제
        return dao.promotionDelete(promotionNum);
    }

    public void incrementVisitCount(String promotionNum) {
        dao.incrementVisitCount(promotionNum);
    }

    public void incrementDownCount(String promotionNum) {
        dao.incrementDownCount(promotionNum);
    }
}