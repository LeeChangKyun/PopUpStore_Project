package com.popup.project.board.review.utils;

public class ReviewBoardPage
{
	public static String pagingStr(int totalCount, int pageSize, int blockPage, int pageNum, String pageUrl) {
	    StringBuilder pagingStr = new StringBuilder();

	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);
	    int currentBlock = (pageNum - 1) / blockPage;
	    int startPage = currentBlock * blockPage + 1;
	    int endPage = startPage + blockPage - 1;

	    if (endPage > totalPages) {
	        endPage = totalPages;
	    }

	    if (pageNum > 1) {
	        pagingStr.append("<a href='").append(pageUrl).append("?page=1'>«</a> ");
	    }

	    if (pageNum > 1) {
	        pagingStr.append("<a href='").append(pageUrl).append("?page=").append(pageNum - 1).append("'>‹</a> ");
	    }

	    for (int i = startPage; i <= endPage; i++) {
	        if (i == pageNum) {
	            pagingStr.append("<b>").append(i).append("</b> ");
	        } else {
	            pagingStr.append("<a href='").append(pageUrl).append("?page=").append(i).append("'>").append(i).append("</a> ");
	        }
	    }

	    if (pageNum < totalPages) {
	        pagingStr.append("<a href='").append(pageUrl).append("?page=").append(pageNum + 1).append("'>›</a> ");
	    }

	    if (pageNum < totalPages) {
	        pagingStr.append("<a href='").append(pageUrl).append("?page=").append(totalPages).append("'>»</a>");
	    }

	    return pagingStr.toString();
	}
}
