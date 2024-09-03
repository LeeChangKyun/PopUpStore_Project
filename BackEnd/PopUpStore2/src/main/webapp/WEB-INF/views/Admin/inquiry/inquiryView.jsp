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
    <title>문의 게시판</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <style>
        /* @font-face를 사용하여 SUIT-Regular 폰트 정의 */
        @font-face {
            font-family: 'SUIT';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_suit@1.0/SUIT-Bold.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }

        .brand-font-700 {
            font-family: 'SUIT', sans-serif;
            font-weight: 700;
            font-size: 29px;
        }

        .centered-text {
            text-align: center;
        }

        .example-text {
            margin: 0;
        }

        .body {
            background-color:#5e5e5e;
            margin: 0;
            flex-direction: column;
            height: 100%;
            display: flex;
        }
        body {
            background-color:#3D454A;
            margin: 0;
            flex-direction: column;
            height: 100%;
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
        main {
            flex: 1;
            padding-bottom: 80px; /* 푸터 높이만큼 여백 추가 */
        }
        /* 푸터 스타일 */
        footer {
            padding: 10px;
            text-align: center;
            background-color: #fff;
            border-top: none;
            width: 100%;
            bottom: 0;
            left: 0;
            box-sizing: border-box; /* 패딩을 너비에 포함시킴 */
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
            padding-bottom: 20px; /* 푸터의 높이만큼 여백 추가 */
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

           	댓글토글 */
        #comment-list {
            display: none; /* 기본적으로 댓글 목록을 숨김 */
        }
        .icon-group svg {
            cursor: pointer;
        }
        
		/* 좋아요 스타일 */
        .icon-group svg {
		    width: 24px;
		    height: 24px;
		    color: #060606; /* 기본 아이콘 색상 */
		    cursor: pointer;
		}
		
		.icon-group .liked svg {
		    color: #e25555; /* 빨간색 하트 색상 */
		}
		
		.icon-group .not-liked svg {
		    color: #060606; /* 기본 색상 */
		}
		
		/* 좋아요 확인 css*/
		.modal {
		    display: none;
		    position: fixed;
		    z-index: 1;
		    left: 0;
		    top: 0;
		    width: 100%;
		    height: 100%;
		    overflow: auto;
		    background-color: rgb(0,0,0);
		    background-color: rgba(0,0,0,0.4);
		}
		
		.modal-content {
		    background-color: #fefefe;
		    margin: 15% auto;
		    padding: 20px;
		    border: 1px solid #888;
		    width: 80%;
		}
		
		.close-btn {
		    color: #aaa;
		    float: right;
		    font-size: 28px;
		    font-weight: bold;
		}
		
		.close-btn:hover,
		.close-btn:focus {
		    color: black;
		    text-decoration: none;
		    cursor: pointer;
		}
    </style>

    <script>
        function inquirydeletePost(inquiry_num){
            var confirmed = confirm("정말로 삭제하겠습니까?"); 
            if (confirmed) {
                var form = document.writeFrm;      
                form.method = "post";  
                form.action = "inquiryDelete";
                form.submit();  
            }
        }

        document.addEventListener("DOMContentLoaded", function() {
            var likeIcon = document.getElementById('like-icon');
            var likeCount = document.getElementById('like-count');

            likeIcon.addEventListener('click', function() {
            	var inquiryNum = ${inquirysimplebbsDTO.inquiry_num != null ? inquirysimplebbsDTO.inquiry_num : 'null'};
            	var userNick = '${sessionScope.userNick}';
            	var userLiked = ${userLiked != null ? userLiked : 'false'};

                // AJAX 요청을 통해 좋아요 상태 토글
                $.ajax({
                    url: '/inquiry/toggleLike',
                    method: 'POST',
                    data: {
                        inquiryNum: inquiryNum,
                        userNick: userNick
                    },
                    success: function(response) {
                        // 응답 처리
                        likeCount.textContent = response.likeCount + ' 좋아요';
                        if (response.userLiked) {
                            likeIcon.classList.add('liked');
                            likeIcon.classList.remove('not-liked');
                        } else {
                            likeIcon.classList.add('not-liked');
                            likeIcon.classList.remove('liked');
                        }
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('Error during AJAX request:', textStatus, errorThrown);
                    }
                });
            });
        });
        
        //좋아요 누른 사람 확인
        document.addEventListener("DOMContentLoaded", function() {
            var likeText = document.getElementById('like-count');
            var modal = document.getElementById('like-users-modal');
            var closeBtn = document.getElementsByClassName('close-btn')[0];
            var likeUsersList = document.getElementById('like-users-list');

            likeText.addEventListener('click', function() {
                var inquiryNum = ${inquirysimplebbsDTO.inquiry_num};

                // AJAX 요청을 통해 좋아요 사용자 목록 가져오기
                $.ajax({
                    url: '/inquiry/likeUsers',
                    method: 'GET',
                    data: { inquiryNum: inquiryNum },
                    success: function(response) {
                        // 모달 창에 사용자 목록 표시
                        likeUsersList.innerHTML = '';
                        response.forEach(function(user) {
                            var listItem = document.createElement('li');
                            listItem.textContent = user;
                            likeUsersList.appendChild(listItem);
                        });
                        modal.style.display = 'block';
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.error('Error fetching like users:', textStatus, errorThrown);
                    }
                });
            });

            // 모달 닫기
            closeBtn.addEventListener('click', function() {
                modal.style.display = 'none';
            });

            // 모달 외부 클릭 시 닫기
            window.addEventListener('click', function(event) {
                if (event.target == modal) {
                    modal.style.display = 'none';
                }
            });
        });
    </script>
</head>
<body>

    <form name="writeFrm">
        <input type="hidden" name="inquiry_num" value="${inquirysimplebbsDTO.inquiry_num}" />
    </form>
    <div class="container-custom mt-5">
        <!-- 게시글 상세 내용 -->
        <div class="post-section">
            <div class="post-header">
                <h1 class="post-title">${inquirysimplebbsDTO.inquiry_title}</h1>
                <p class="post-meta">작성자: ${inquirysimplebbsDTO.user_nick} | 작성일: ${inquirysimplebbsDTO.inquiry_create_date} | 조회수: ${inquirysimplebbsDTO.visitcount}</p>
            </div>
            <div class="post-content">
                <p>${inquirysimplebbsDTO.inquiry_content}</p>
            </div>
            <table>
                <tr>
                    <td>
                       <c:if test="${not empty inquirysimplebbsDTO.inquiry_sfile}">
					    <tr>
					        <td>첨부파일</td>
					        <!-- 파일 다운로드 링크 -->
					        <a href="${pageContext.request.contextPath}/inquiryDownload?inquiry_ofile=${inquirysimplebbsDTO.inquiry_ofile}&inquiry_sfile=${inquirysimplebbsDTO.inquiry_sfile}&inquiry_num=${inquirysimplebbsDTO.inquiry_num}">
					            ${inquirysimplebbsDTO.inquiry_ofile} [다운로드]
					        </a>
					    </tr>
					</c:if>
                </tr>
            </table>

            <!-- 아이콘 좋아요 댓글 -->
		<div class="icon-group">
			 <button id="like-icon" class="btn btn-link ${userLiked ? 'liked' : 'not-liked'}">
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314"/>
                    </svg>
                    </button>
                    <p id="like-count">${inquirysimplebbsDTO.likeCount}좋아요</p>

                <svg id="comment-toggle-icon" onclick="toggleComments()" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots-fill" viewBox="0 0 16 16">
                    <path d="M16 8c0 3.866-3.582 7-8 7a9 9 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7M5 8a1 1 0 1 0-2 0 1 1 0 0 0 2 0m4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
                </svg>
                <p>댓글 ${commentCount}</p>
            </div>
            
            
            
			            <!-- 좋아요 누른사람 확인 -->
			<div id="like-users-modal" class="modal" style="display:none;">
			    <div class="modal-content">
			        <span class="close-btn">&times;</span>
			        <h2>좋아요</h2>
			        <ul id="like-users-list">
			            <!-- 사용자 목록이 여기 표시됩니다 -->
			        </ul>
			    </div>
			</div>

            <!-- 댓글 목록 -->
            <div class="divider"></div> <!-- 구분선 추가 -->
            <div id="comment-list" class="comment-list">
                <c:forEach items="${comments}" var="comment">
                    <div class="comment-item">
                        <p class="comment-meta">작성자: ${comment.user_nick} | 작성일: ${comment.created_at}</p>
                        <p class="comment-content">${comment.inquiry_comment_content}</p>
                        <c:choose>
                            <c:when test="${comment.user_nick == sessionScope.userNick or sessionScope.userId == 'Admin'}">
                                <form action="${pageContext.request.contextPath}/Admin/inquirydeleteComment" method="post" style="display:inline;">
                                    <input type="hidden" name="inquiry_comment_id" value="${comment.inquiry_comment_id}" />
                                    <input type="hidden" name="inquiry_num" value="${inquirysimplebbsDTO.inquiry_num}" />
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
                <form class="comment-form" action="${pageContext.request.contextPath}/Admin/inquiry/addComment" method="post">
                    <input type="hidden" name="inquiry_num" value="${inquirysimplebbsDTO.inquiry_num}" />
                    <div class="input-group">
                        <textarea name="inquiry_comment_content" placeholder="댓글을 입력하세요..."></textarea>
                        <button type="submit" class="btn btn-sm">댓글 작성</button>
                    </div>
                </form>
            </div>

            <!-- 버튼 그룹 -->
		            <div class="action-buttons">
		            <!-- 수정 및 삭제 버튼 조건부 표시 -->
		            <c:choose>
		                <c:when test="${inquirysimplebbsDTO.user_nick == sessionScope.userNick or sessionScope.userId == 'Admin'}">
		                    <div class="btn-group">
		                    <button type="button" onclick="location.href='/Admin/inquiryEdit?&inquiry_num=${inquirysimplebbsDTO.inquiry_num}';" class="btn btn-back">수정</button>
		                    <button type="button" onclick="inquirydeletePost(${inquirysimplebbsDTO.inquiry_num});" class="btn btn-back">삭제</button>
		                    </div>
		                </c:when>
		                <c:otherwise>
		                    <!-- 일반 사용자 또는 관리자 외에는 수정 및 삭제 버튼을 숨김 -->
		                </c:otherwise>
		            </c:choose>
		            <button type="button" onclick="location.href='/Admin/inquiry/inquiryList';" class="btn btn-back">목록으로 돌아가기</button>
		        </div>
		    </div>
        </div>
    <br/>
    <!-- 댓글 토글 -->
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
