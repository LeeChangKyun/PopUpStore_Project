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
    <title>리뷰 상세보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
    <script type="text/javascript">
    
	    function confirmReviewEdit(reviewNum) {
	        if (confirm("게시글을 수정하시겠습니까?")) {
	            window.location.href = "/Admin/review/reviewEdit?reviewNum=" + reviewNum;
	        }
	    }
	    function confirmReviewDelete(reviewNum) {
	        if (confirm("게시글을 삭제하시겠습니까?")) {
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
	                    window.location.href = '/Admin/review/reviewList';
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
	    function confirmReviewCommentDelete(commentId) {
	        if (confirm("댓글을 삭제하시겠습니까?")) {
	        	fetch('/Admin/reviewCommentDelete', {
	        	    method: 'POST',
	        	    headers: {
	        	        'Content-Type': 'application/x-www-form-urlencoded',
	        	    },
	        	    body: new URLSearchParams({
	        	        commentId: commentId
	        	    })
	        	})
	        	.then(response => response.text())
	        	.then(result => {
	        	    if (result === 'success') {
	        	        alert("댓글이 삭제되었습니다.");
	        	        document.getElementById('comment-' + commentId).remove(); // 댓글 삭제
	        	    } else {
	        	        alert(result); // 서버에서 반환한 오류 메시지를 보여줌
	        	    }
	        	})
	        	.catch(error => {
	        	    console.error('Error:', error);
	        	    alert("오류가 발생하였습니다.");
	        	});
	        }
	    }
        // 좋아요 기능...
        document.addEventListener("DOMContentLoaded", function() {
	        const likeIcon = document.getElementById('likeIcon');
	        const likeCount = document.getElementById('likeCount');
	        
	        // 서버에서 전달된 초기 값
	        const initialLikeCount = ${dto.reviewLikecount}; // 서버에서 전달된 좋아요 수
	        const isLiked = "${isLiked}" === "true"; // 서버에서 전달된 사용자의 좋아요 여부
	
	        // 초기 상태 설정
	        likeCount.textContent = initialLikeCount;
	        if (isLiked) {
	            likeIcon.className = 'fas fa-heart';
	            likeIcon.style.color = 'red';
	        } else {
	            likeIcon.className = 'far fa-heart';
	            likeIcon.style.color = 'black';
	        }
	
	        // 좋아요 버튼 클릭 이벤트 핸들러
	        likeIcon.addEventListener('click', function() {
	            const reviewNum = ${dto.reviewNum};
	            toggleLike(reviewNum);
	        });
	
	        function toggleLike(reviewNum) {
	            const userNick = '<%= (String) session.getAttribute("userNick") %>'; // 세션에서 직접 가져오기
	            if (!userNick) {
	                console.error("User nickname is not available.");
	                return;
	            }
	
	            fetch('/review/toggleLike', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/x-www-form-urlencoded',
	                },
	                body: new URLSearchParams({
	                    reviewNum: reviewNum,
	                    userNick: userNick
	                })
	            })
	            .then(response => response.json())
	            .then(data => {
	                let currentCount = parseInt(likeCount.textContent);
	
	                if (!isNaN(currentCount)) {
	                    if (data.userLiked) {
	                        likeIcon.className = 'fas fa-heart';
	                        likeIcon.style.color = 'red';
	                        likeCount.textContent = currentCount + 1;
	                    } else {
	                        likeIcon.className = 'far fa-heart';
	                        likeIcon.style.color = 'black';
	                        likeCount.textContent = currentCount - 1;
	                    }
	                } else {
	                    console.error("좋아요 수를 가져오는 데 문제가 발생했습니다.");
	                    likeCount.textContent = data.likeCount; // 서버에서 받은 실제 좋아요 수로 업데이트
	                }
	            })
	            .catch(error => console.error('Error:', error));
	        }
	    });
    </script>
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

        <!-- 좋아요 아이콘을 렌더링할 때 isLiked 값에 따라 초기 상태를 설정 -->
		<div class="icon-group">
		    <!-- 좋아요 아이콘 -->
		    <i id="likeIcon" class="fa${isLiked ? 's' : 'r'} fa-heart" 
		       onclick="toggleLike(${post.reviewNum})" 
		       style="color: ${isLiked ? 'red' : 'black'};"></i>
		    
		    <!-- 좋아요 개수 -->
		    <p id="likeCount">${dto.reviewLikecount}</p>
		    
		    <!-- 댓글 아이콘 -->
		    <i class="fas fa-comment-dots"></i>
			<p>${comments.size()}</p>		
		</div>

        <div class="comment-section">
            <h2 class="comment-header">댓글</h2>
            <table class="table table-bordered comment-table">
                <thead>
                    <tr>
                        <th>작성자</th>
                        <th>내용</th>
                        <th>작성일</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="comment" items="${comments}">
					    <tr id="comment-${comment.commentId}">
					        <td>${comment.userNick}</td>
					        <td>${comment.commentContent}</td>
					        <td>${comment.formattedCommentDate}</td>
					        <td>
							    <button type="button" class="btn btn-danger btn-sm" onclick="confirmReviewCommentDelete(${comment.commentId})">삭제</button>
							</td>
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
        
        <c:if test="${not empty sessionScope.role}">
		    <c:out value="${sessionScope.role}" />
		</c:if>

        <!-- 댓글 작성 폼 -->
        <form action="${pageContext.request.contextPath}/Admin/reviewCommentAdd" method="post" class="mt-4">
            <input type="hidden" name="reviewNum" value="${dto.reviewNum}" />
            <div class="input-group">
                <span class="input-group-text">${sessionScope.userNick}</span>
                <textarea name="commentContent" placeholder="" required class="form-control"></textarea>
                <button type="submit" class="btn btn-primary">댓글 작성</button>
            </div>
        </form>

        <div class="text-center mt-5">
		    <c:if test="${dto.userNick == sessionScope.userNick}">
		        <button type="button" class="btn btn-warning" onclick="confirmReviewEdit(${dto.reviewNum})">수정하기</button>
		    </c:if>
		    <button type="button" class="btn btn-danger" onclick="confirmReviewDelete(${dto.reviewNum})">삭제하기</button>
		    <button type="button" class="btn btn-secondary" onclick="location.href='/Admin/review/reviewList';">목록으로</button>
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
