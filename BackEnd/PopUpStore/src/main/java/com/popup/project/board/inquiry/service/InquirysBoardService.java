package com.popup.project.board.inquiry.service;

import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.popup.project.board.inquiry.dto.InquiryDTO;
import com.popup.project.board.inquiry.dto.InquiryBoardService;
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
        if (inquiryOfile != null && !inquiryOfile.isEmpty()) {
            String savedOfileName = fileUploadService.saveFile(inquiryOfile);
            dto.setInquiry_ofile(fileUploadService.getOriginalFileName(inquiryOfile));
            dto.setInquiry_sfile(savedOfileName);
            
            fileUploadService.deleteFile(prevOfile);
        } else {
            dto.setInquiry_ofile(prevOfile);
        }
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