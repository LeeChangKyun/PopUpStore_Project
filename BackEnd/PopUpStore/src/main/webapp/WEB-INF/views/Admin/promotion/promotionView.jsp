<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/adminheader.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세보기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #343a40;
        }
        header {
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color: #343a40;
            border: none;
            padding: 15px;
        }

        .nav {
            display: flex;
            gap: 50px;
            align-items: center; /* 수직 정렬 */
            justify-content: center; /* 수평 가운데 정렬 */
            flex-grow: 1; /* 공간 차지 */
        }
        .nav a, .nav .dropdown-toggle {
            text-decoration: none;
            color: #fff; /* 헤더 폰트 색 */
            font-size: 16px;
            position: relative;
            background: none;
            display: flex;
            align-items: center;
            line-height: 1.5; /* 행간 조정 */
            letter-spacing: 0.5px; /* 자간 조정 */
        }
        .nav .dropdown-menu {
            display: none; /* 기본적으로 숨김 */
            position: absolute; /* 위치를 절대적으로 설정 */
            left: 50%; /* 왼쪽을 50%로 설정 */
            transform: translateX(-50%); /* 왼쪽 위치의 50%만큼 왼쪽으로 이동 */
            top: 100%; /* 드롭다운 메뉴를 버튼 아래에 위치 */
            z-index: 1000; /* 다른 요소 위에 보이도록 설정 */
        }
        .nav .dropdown-menu.show {
            display: block; /* 클래스가 show인 경우 보이게 설정 */
        }
        .nav a:last-child {
            margin-left: -5px; /* 원하는 간격으로 조정 */
        }
        .nav a.beta {
            color: #2196F3;
            background-color: #E3F2FD;
            padding: 3px 5px;
            border-radius: 3px;
        }
        .nav .dropdown-toggle {
            outline: none;
            box-shadow: none;
            border-color: transparent;
        }
        .nav .dropdown-toggle:hover {
            color: #2196F3; /* 마우스를 올렸을 때 글자색 변경 */
        }
        .auth {
            display: flex;
            gap: 15px; /* 로그인 버튼과의 간격 조정 */
            margin-left: 20px; /* 로그인 버튼과의 간격 조정 */
        }
        .auth a {
            text-decoration: none;
            color: #fff; /* 로그인 텍스트 색상 */
            font-size: 16px;
            display: flex;
            align-items: center;
        }
        .auth button {
            background: none; /* 버튼 배경 없애기 */
            border: none; /* 버튼 경계선 없애기 */
            padding: 0; /* 패딩 없애기 */
            cursor: pointer; /* 커서 모양 변경 */
        }
        .dropdown-toggle::after {
            content: none; /* 기본 화살표 숨김 */
        }
        .dropdown-menu .dropdown-item {
            color: black; /* 드롭다운 아이템의 텍스트 색상 */
        }
        .dropdown-menu .dropdown-item:hover {
            background-color: #060606; /* 원하는 색상으로 변경 */
            color: #fff; /* 호버 시 텍스트 색상 변경 */
            display: inline-block; /* 인라인 블록 요소로 변경 */
            padding: 5px 10px; /* 원하는 패딩 값으로 조정 */
        }
        footer {
            background-color: #000; /* 배경색을 bg-dark 클래스로 변경하였으므로 주석 처리 */
            color: #fff; /* 글자 색상을 흰색으로 변경 */
            padding: 20px;
            text-align: center;
            border-top: 1px solid #ddd;
        }
        footer p {
            margin: 5px 0;
        }
        footer .footer-nav {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 10px;
            text-decoration: underline;
        }
        footer .footer-nav a {
            text-decoration: none;
            color: #fff; /* 링크 색상을 흰색으로 변경 */
        }
        /* SVG 아이콘 드롭다운 위치 수정 */
        .auth .dropdown-menu {
            right: 0; /* 오른쪽으로 정렬 */
            left: auto; /* 기본값은 왼쪽이므로 오른쪽으로 이동 */
        }
        /* SVG 아이콘 호버 색상 변경 */
        .auth .dropdown-toggle:hover svg {
            fill: #2196F3; /* SVG 아이콘의 색상 변경 */
        }

        /* ====================헤더푸터css끝============================================================== */



        .container-custom {
            max-width: 800px; /* 원하는 최대 너비로 조정 */
            padding: 0 15px; /* 양쪽 패딩 조정 */
            margin: 0 auto; /* 가운데 정렬 */
        }
        .post-section {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin: 20px 0;
            padding: 20px; /* 추가된 패딩 */
        }
        .post-header {
            border-bottom: 1px solid #ddd;
            padding-bottom: 20px; /* 아래쪽 패딩 추가 */
        }
        .post-title {
            font-size: 2rem;
            margin-bottom: 10px;
            color: #333;
        }
        .post-meta {
            font-size: 0.875rem;
            color: #6c757d;
        }
        .post-content {
            padding: 20px 0; /* 위와 아래 패딩 조정 */
        }
        .btn-back {
            background-color: #4e555c;
            color: #fff;
            border-radius: 5px;
            text-decoration: none;
            padding: 8px 12px;
        }
        .btn-back:hover {
            background-color: #3b434f;
            color: #fff;
        }
        .post-image {
            max-width: 100%;
            border-radius: 8px;
            margin-top: 20px;
        }
        .icon-group {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            gap: 15px; /* 아이콘 간격 조정 */
            margin-top: 20px; /* 위쪽 여백 추가 */
        }
        .icon-group svg {
            width: 24px; /* 아이콘 크기 조정 */
            height: 24px; /* 아이콘 크기 조정 */
            color: #060606; /* 아이콘 색상 조정 */
            cursor: pointer;
        }
        .icon-group svg:hover {
            color: #2196F3; /* 아이콘 호버 색상 조정 */
        }
        .icon-group p {
            margin: 0; /* 기본 마진 제거 */
            font-size: 15px; /* 글자 크기 조정 */
            color: #333; /* 텍스트 색상 조정 */
        }
        .divider {
            border-top: 1px solid #ddd;
            margin: 20px 0;
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
            resize: none; /* 사이즈 조정 방지 */
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 10px;
        }
        .comment-form button {
            background-color: #4e555c;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 15px; /* 버튼 사이즈 조정 */
            cursor: pointer;
            white-space: nowrap; /* 버튼 텍스트가 줄바꿈되지 않도록 */
        }
        .comment-form button:hover {
            background-color: #3b434f;
        }
        .action-buttons {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 20px;
        }
        .action-buttons .btn-group {
            display: flex;
            gap: 10px; /* 버튼 간격 조정 */
        }
        .comment-item {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            margin-top: 10px;
        }
        .comment-item .comment-meta {
            font-size: 12px;
            color: #6c757d;
            margin-bottom: 5px;
        }
        .comment-item .comment-content {
            font-size: 15px;
            color: #333;
        }
        
/*        	댓글토글 */
        #comment-list {
            display: none; /* 기본적으로 댓글 목록을 숨김 */
        }
        .icon-group svg {
            cursor: pointer;
        }
    </style>
    
	<script>
		function promotiondeletePost(promotion_num){
		    var confirmed = confirm("정말로 삭제하겠습니까?"); 
		    if (confirmed) {
		        var form = document.writeFrm;      
		        form.method = "post";  
		        form.action = "promotionDelete";
		        form.submit();  
		    }
		}
	</script>
    
</head>
<body>

	<form name="writeFrm">
		<input type="hidden" name="promotion_num" value="${simplebbsDTO.promotion_num }" />
	</form>
    <div class="container-custom mt-5">
        <!-- 게시글 상세 내용 -->
        <div class="post-section">
            <div class="post-header">
                <h1 class="post-title">${ simplebbsDTO.promotion_title }</h1>
                <p class="post-meta">작성자: ${ simplebbsDTO.user_nick } | 작성일: ${ simplebbsDTO.promotion_create_date } | 조회수: ${ simplebbsDTO.visitcount }</p>
            </div>
	         <div class="post-content">
	            <p>${ simplebbsDTO.promotion_content }</p>
	        </div>
	        <table>
	            <tr>
	                <td>
	                    <c:if test="${ not empty simplebbsDTO.promotion_sfile }">
            		      <td>첨부파일</td>
	                        <!-- 파일 다운로드 링크 -->
	                        <a href="${pageContext.request.contextPath}/Admin/promotionDownload?promotion_ofile=${ simplebbsDTO.promotion_ofile }&promotion_sfile=${ simplebbsDTO.promotion_sfile }&promotion_num=${ simplebbsDTO.promotion_num }">
	                            ${ simplebbsDTO.promotion_ofile } [다운로드]
	                        </a>
	                    </c:if>
	                </td>
	                <c:if test="${ not empty simplebbsDTO.promotion_sfile }">
	                <td>다운로드수</td>
	                <td>${ simplebbsDTO.downcount }</td>
	                </c:if>
	            </tr>
		    </table>

		  <!-- 아이콘 및 댓글 수 표시 -->
		<div class="icon-group">
		    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
		        <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
		    </svg>
		    <p>좋아요 10</p>
		    <svg id="comment-toggle-icon" onclick="toggleComments()" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots-fill" viewBox="0 0 16 16">
		        <path d="M16 8c0 3.866-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7M5 8a1 1 0 1 0-2 0 1 1 0 0 0 2 0m4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
		    </svg>
		    <p>댓글 ${commentCount}</p>
		</div>



			<!-- 댓글 목록 -->
	<div class="divider"></div> <!-- 구분선 추가 -->
		<div id="comment-list" class="comment-list">
		    <c:forEach items="${comments}" var="comment">
		        <div class="comment-item">
		            <p class="comment-meta">작성자: ${comment.user_nick} | 작성일: ${comment.created_at}</p>
		            <p class="comment-content">${comment.promotion_comment_content}</p>
		            <c:choose>
		                <c:when test="${comment.user_nick == sessionScope.userNick or sessionScope.userId == 'Admin'}">
		                    <form action="${pageContext.request.contextPath}/Admin/promotion/promotiondeleteComment" method="post" style="display:inline;">
		                        <input type="hidden" name="promotion_comment_id" value="${comment.promotion_comment_id}" />
		                        <input type="hidden" name="promotion_num" value="${simplebbsDTO.promotion_num}" />
		                        <button type="submit" class="btn btn-sm btn-danger">삭제</button>
		                    </form>
		                </c:when>
		            </c:choose>
		        </div>
		    </c:forEach>
		</div>

			 <!-- 댓글 작성 폼 -->
		<div class="divider"></div> <!-- 구분선 추가 -->
		<div class="comment-section">
		    <h2 class="comment-header">댓글 작성</h2>
		    <form class="comment-form" action="${pageContext.request.contextPath}/Admin/promotion/promotionaddComment" method="post">
		        <input type="hidden" name="promotion_num" value="${simplebbsDTO.promotion_num}" />
		        <div class="input-group">
		            <textarea name="promotion_comment_content" placeholder="댓글을 입력하세요..."></textarea>
		            <button type="submit" class="btn btn-sm">댓글 작성</button>
		        </div>
		    </form>
		</div>
		</div>
		
<!-- 		댓글 토글 -->
			<script>
			    function toggleComments() {
			        var commentList = document.getElementById('comment-list');
			        var icon = document.getElementById('comment-toggle-icon');
			
			        // 현재 상태에 따라 댓글 목록을 보이거나 숨김
			        if (commentList.style.display === 'none' || commentList.style.display === '') {
			            commentList.style.display = 'block';
			            icon.style.color = '#2196F3'; // 아이콘 색상 변경 (보임 상태)
			        } else {
			            commentList.style.display = 'none';
			            icon.style.color = '#060606'; // 아이콘 색상 변경 (숨김 상태)
			        }
			    }
			</script>
		
		
          <!-- 버튼 그룹 -->
        <div class="action-buttons">
            <!-- 수정 및 삭제 버튼 조건부 표시 -->
            <c:choose>
                <c:when test="${simplebbsDTO.user_nick == sessionScope.userNick or sessionScope.userId == 'Admin'}">
                    <div class="btn-group">
						<button type="button" onclick="location.href='/Admin/promotionEdit?&promotion_num=${simplebbsDTO.promotion_num}';" class="btn btn-back">수정</button>
                        <button type="button" onclick="promotiondeletePost(${simplebbsDTO.promotion_num});" class="btn btn-back">삭제</button>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 일반 사용자 또는 관리자 외에는 수정 및 삭제 버튼을 숨김 -->
                </c:otherwise>
            </c:choose>
            <button type="button" onclick="location.href='/Admin/promotionList';" class="btn btn-back">목록으로 돌아가기</button>
        </div>
    </div>

    <!-- 푸터 시작 -->
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
