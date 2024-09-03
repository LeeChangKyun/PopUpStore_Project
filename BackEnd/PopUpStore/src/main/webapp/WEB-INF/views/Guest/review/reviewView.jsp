<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 상세보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <style>
        body {
            background-color: #343a40;
            color: #fff;
        }
        .container-custom {
            max-width: 800px;
            padding: 20px;
            margin: 20px auto;
            background-color: #fff;
            color: #000;
            border-radius: 8px;
        }
        .post-header {
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .post-title {
            font-size: 2rem;
            color: #333;
        }
        .post-meta {
            font-size: 0.875rem;
            color: #6c757d;
        }
        .post-content {
            padding: 20px 0;
        }
        .icon-group {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            gap: 15px;
            margin-top: 20px;
        }
        .icon-group svg {
            width: 24px;
            height: 24px;
            cursor: pointer;
        }
        .icon-group p {
            margin: 0;
            font-size: 15px;
            color: #333;
        }
        .comment-section {
            margin-top: 30px;
        }
        .comment-header {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #333;
        }
        .comment-form .input-group {
            width: 100%;
        }
        .comment-form textarea {
            flex: 1;
            height: 100px;
            resize: none;
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 10px;
        }
        .comment-form button {
            background-color: #4e555c;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 15px;
            cursor: pointer;
        }
        .comment-form button:hover {
            background-color: #3b434f;
        }
        .comment-item {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            margin-top: 10px;
        }
        .comment-meta {
            font-size: 12px;
            color: #6c757d;
            margin-bottom: 5px;
        }
        .comment-content {
            font-size: 15px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container-custom">
        <div class="post-header">
            <h1 class="post-title">${dto.reviewTitle}</h1>
            <p class="post-meta">작성자: ${dto.userNick} | 작성일: <fmt:formatDate value="${dto.reviewCreateDate}" pattern="yyyy-MM-dd HH:mm" /> | 조회수: ${dto.reviewViewcount}</p>
        </div>
        <div class="post-content">
            <p>${dto.reviewContent}</p>
        </div>
        <c:choose>
            <c:when test="${dto.reviewOfile != null && !dto.reviewOfile.trim().isEmpty()}">
                <img src="${pageContext.request.contextPath}/uploads/${dto.reviewOfile}" alt="첨부 이미지" class="img-fluid" />
                <br />
                <a href="${pageContext.request.contextPath}/uploads/${dto.reviewOfile}" download>사진 다운</a>
            </c:when>
            <c:otherwise>
                사진 없음
            </c:otherwise>
        </c:choose>

        <div class="icon-group">
		    <!-- 좋아요 하트 아이콘 (게스트는 클릭 불가능) -->
		    <i id="likeIcon" class="fa${dto.reviewLikecount > 0 ? 's' : 'r'} fa-heart" style="color: ${dto.reviewLikecount > 0 ? 'red' : 'black'}; cursor: not-allowed;"></i>
		    <p id="likeCount">${dto.reviewLikecount}</p>
		    <!-- 댓글 아이콘 -->
		    <i class="fas fa-comment-dots"></i>
		    <p>${comments.size()}</p>
		</div>

        <!-- 댓글 리스트 -->
        <div class="comment-section">
            <h2 class="comment-header">댓글</h2>
            <table class="table table-bordered comment-table">
                <thead>
                    <tr>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="comment" items="${comments}">
                        <tr>
                            <td>${comment.userNick}</td>
                            <td>${comment.commentContent}</td>
                            <td>${comment.formattedCommentDate}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty comments}">
                        <tr>
                            <td colspan="3" class="text-center">등록된 댓글이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- 목록으로 버튼 -->
        <div class="text-center mt-5">
            <button type="button" class="btn btn-secondary" onclick="location.href='/Guest/review/reviewList';">목록으로</button>
        </div>
    </div>
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
