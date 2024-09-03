package com.popup.project.board.promotion.service;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.popup.project.board.promotion.dto.PromotionParameterDTO;
import com.popup.project.board.promotion.dto.PromotionBoardDTO;

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

    public int editPost(PromotionBoardDTO dto, MultipartFile promotionOfile, String prevOfile) throws IOException {
        // 새 파일 저장
        if (promotionOfile != null && !promotionOfile.isEmpty()) {
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
            String savedFileName = fileUploadService.saveFile(promotionOfile);
            dto.setPromotion_ofile(fileUploadService.getOriginalFileName(promotionOfile));
            dto.setPromotion_sfile(savedFileName);
        } else {
            // 파일이 없으면 이전 파일 이름을 그대로 사용
            dto.setPromotion_ofile(prevOfile);
        }

        // 게시글 업데이트 로직
        return dao.edit(dto);
    }

    public int promotiondeletePost(String promotionNum) {
        return dao.promotionDelete(promotionNum);
    }

    public void incrementVisitCount(String promotionNum) {
        dao.incrementVisitCount(promotionNum);
    }

    public void incrementDownCount(String promotionNum) {
        dao.incrementDownCount(promotionNum);
    }
}