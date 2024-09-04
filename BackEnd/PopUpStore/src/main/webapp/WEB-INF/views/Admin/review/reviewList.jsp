<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/adminheader.jsp" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>리뷰 목록</title>
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
	    <style>
	        body {
	            background-color: #343a40;
	            color: #fff;
	        }
	        .table {
			    border-collapse: separate;
			    border-spacing: 0;
			    width: 100%;
				border-radius: 10px; 
		    	overflow: hidden; 	
	    	}
	        .table-container {
	            margin: 20px auto;
	            max-width: 50%; 
	        }
	        .table thead {
	            background-color: #343a40;
	            color: #fff;
	        }
	        .table td, .table th {
	            vertical-align: middle;
	            font-size: 14px;
	        }
	        .search-form {
	            margin: 20px auto;
	            max-width: 25%; 
	        }
	        .search-form .input-group {
	            margin-bottom: 15px;
	        }
	        .btn-primary {
	            background-color: #007bff;
	            border-color: #007bff;
	        }
	        .btn-primary:hover {
	            background-color: #0056b3;
	            border-color: #004085;
	        }
	        .write-button {
	            margin-top: 20px;
	            text-align: right;
	        }
	        .pagination-container {
	            margin-top: 20px;
	            margin-bottom: 20px;
	        }
	    </style>
	    <script>
	        function deletePost(reviewNum) {
	            if (confirm("정말 이 게시글을 삭제하시겠습니까?")) {
	                fetch('/reviewDelete', {
	                    method: 'POST',
	                    headers: {
	                        'Content-Type': 'application/x-www-form-urlencoded',
	                    },
	                    body: new URLSearchParams({
	                        reviewNum: reviewNum
	                    })
	                })
	                .then(response => response.text())
	                .then(result => {
	                    if (result === 'success') {
	                        alert("게시글이 삭제되었습니다.");
	                        location.reload();
	                    } else {
	                        alert("게시글 삭제에 실패하였습니다.");
	                    }
	                })
	                .catch(error => {
	                    console.error('Error:', error);
	                    alert("오류가 발생하였습니다.");
	                });
	            }
	        }
	    </script>
	</head>
	<body>
	    <div class="container table-container">
	        <h2 class="text-center">리뷰 게시판</h2>
	
	        <!-- 리뷰 게시판 테이블 -->
	        <table class="table table-secondary table-hover">
	            <thead class="text-center">
	                <tr>
	                    <th>번호</th>
	                    <th>제목</th>
	                    <th>작성자</th>
	                    <th>조회수</th>
	                    <th>좋아요</th>
	                    <th>작성일</th>
	                    <th>사진</th>
	                    <th>삭제</th>
	                </tr>
	            </thead>
	            <tbody>
	                <c:forEach var="post" items="${boardList}">
	                    <tr align="center">
	                        <td>${post.reviewNum}</td>
	                        <td>
	                            <a href="<c:url value='/Admin/review/reviewView' />?reviewNum=${post.reviewNum}">
	                                ${post.reviewTitle}
	                                <c:choose>
	                                    <c:when test="${post.commentCount > 0}">
	                                        <span style="color:green;">[${post.commentCount}]</span>
	                                    </c:when>
	                                    <c:otherwise>
	                                        <span>[0]</span>
	                                    </c:otherwise>
	                                </c:choose>
	                            </a>
	                        </td>
	                        <td>${post.userNick}</td>
	                        <td>${post.reviewViewcount}</td>
	                        <td>${post.reviewLikecount}</td>
	                        <td><fmt:formatDate value="${post.reviewCreateDate}" pattern="yyyy-MM-dd HH:mm" /></td>
	                        <td>
	                            <c:choose>
	                                <c:when test="${post.reviewOfile != null && !post.reviewOfile.isEmpty()}">
	                                    ✔
	                                </c:when>
	                                <c:otherwise>
	                                    ✖
	                                </c:otherwise>
	                            </c:choose>
	                        </td>
	                        <td>
	                        	<button type="button" class="btn btn-danger btn-sm" onclick="deletePost(${post.reviewNum})">삭제</button>
	                        </td>
	                    </tr>
	                </c:forEach>
	                <c:if test="${empty boardList}">
	                    <tr>
	                        <td colspan="8" align="center">등록된 게시물이 없습니다.</td>
	                    </tr>
	                </c:if>
	            </tbody>
	        </table>
	
	        <!-- 페이지 네비게이션 및 글쓰기 버튼 -->
			<div class="pagination-container text-center">            
	            <div>${pagingImg}</div>
	            <div class="write-button">
	                <button type="button" class="btn btn-primary" onclick="location.href='/Admin/review/reviewWrite';">글쓰기</button>
	            </div>
	        </div>
	    </div>
	
	    <!-- 검색 폼 페이지 하단에 배치 -->
	    <form method="get" action="/Admin/review/reviewList" class="search-form">
		    <div class="input-group">
		        <select name="searchField" class="form-select">
		            <option value="review_title" ${param.searchField == 'review_title' ? 'selected' : ''}>제목</option>
		            <option value="review_content" ${param.searchField == 'review_content' ? 'selected' : ''}>내용</option>
		            <option value="user_nick" ${param.searchField == 'user_nick' ? 'selected' : ''}>작성자</option>
		        </select>
		        <input type="text" name="searchWord" value="${param.searchWord}" class="form-control" placeholder="" />
		        <button type="submit" class="btn btn-primary">검색하기</button>
		    </div>
		</form>
	
	    <%@ include file="/WEB-INF/views/Common/footer.jsp" %>
	    
	    <script>
	        const dropdowns = document.querySelectorAll('.dropdown');
	
	        dropdowns.forEach(dropdown => {
	            dropdown.addEventListener('mouseenter', () => {
	                dropdown.querySelector('.dropdown-menu').classList.add('show'); // 드롭다운 메뉴 보이기
	            });
	
	            dropdown.addEventListener('mouseleave', () => {
	                dropdown.querySelector('.dropdown-menu').classList.remove('show'); // 드롭다운 메뉴 숨기기
	            });
	        });
	    </script>
	    
	</body>
</html>
