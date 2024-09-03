package com.popup.project.board.promotion.service;

import org.springframework.stereotype.Service;

@Service
public class PromotionPagingService {

    public static final int PAGE_SIZE = 10;
    public static final int BLOCK_PAGE = 2;

    public String generatePaging(int totalRecordCount, int pageNum, String page, String searchField, String searchKeyword) {
        StringBuilder pagingStr = new StringBuilder();

        int totalPage = (int) Math.ceil((double) totalRecordCount / PAGE_SIZE);
        int startPage = (((pageNum - 1) / BLOCK_PAGE) * BLOCK_PAGE) + 1;

        if (startPage != 1) {
            appendPagingLink(pagingStr, page, 1, searchField, searchKeyword, "<<");
            appendPagingLink(pagingStr, page, startPage - BLOCK_PAGE, searchField, searchKeyword, "<");
        }

        int blockCount = 1;
        while (blockCount <= BLOCK_PAGE && startPage <= totalPage) {
            if (startPage == pageNum) {
                pagingStr.append("&nbsp;<b>").append(startPage).append("</b>&nbsp;");
            } else {
                appendPagingLink(pagingStr, page, startPage, searchField, searchKeyword, String.valueOf(startPage));
            }
            startPage++;
            blockCount++;
        }

        if (startPage <= totalPage) {
            appendPagingLink(pagingStr, page, startPage, searchField, searchKeyword, ">");
            appendPagingLink(pagingStr, page, totalPage, searchField, searchKeyword, ">>");
        }

        return pagingStr.toString();
    }

    private static void appendPagingLink(StringBuilder pagingStr, String page, int pageNum, String searchField, String searchKeyword, String text) {
        pagingStr.append("<a href='").append(page).append("pageNum=").append(pageNum);
        if (searchField != null && !searchField.isEmpty()) {
            pagingStr.append("&searchField=").append(searchField);
        }
        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            pagingStr.append("&searchKeyword=").append(searchKeyword);
        }
        pagingStr.append("'>").append(text).append("</a>&nbsp;");
    }
}