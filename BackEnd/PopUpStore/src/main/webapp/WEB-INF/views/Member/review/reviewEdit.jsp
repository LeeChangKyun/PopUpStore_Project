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
	    <title>리뷰 수정</title>
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
	    <style>
	        body {
	            margin: 0;
	            font-family: Arial, sans-serif;
	            background-color: #343a40;
	            color: #fff;
	            display: flex;
	            flex-direction: column;
	            min-height: 100vh;
	        }
	        .header {
	            display: flex;
	            align-items: center;
	            padding: 10px 100px;
	            justify-content: space-between;
	            position: sticky;
	            top: 0;
	            z-index: 1000;
	            background-color: #343a40;
	        }
	        .nav {
	            display: flex;
	            gap: 50px;
	            align-items: center;
	            justify-content: center;
	            flex-grow: 1;
	        }
	        .nav a, .nav .dropdown-toggle {
	            text-decoration: none;
	            color: #fff;
	            font-size: 16px;
	            position: relative;
	            background: none;
	            display: flex;
	            align-items: center;
	            line-height: 1.5;
	            letter-spacing: 0.5px;
	        }
	        .nav .dropdown-menu {
	            display: none;
	            position: absolute;
	            left: 50%;
	            transform: translateX(-50%);
	            top: 100%;
	            z-index: 1000;
	        }
	        .nav .dropdown-menu.show {
	            display: block;
	        }
	        .auth {
	            display: flex;
	            gap: 15px;
	            margin-left: 20px;
	        }
	        .auth a {
	            text-decoration: none;
	            color: #fff;
	            font-size: 16px;
	            display: flex;
	            align-items: center;
	        }
	        .container {
	            max-width: 600px;
	            width: 100%;
	            background: #f8f9fa;
	            padding: 20px;
	            border-radius: 8px;
	            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	            color: #343a40;
	            text-align: center;
	            margin: 20px auto;
	        }
	        h2 {
	            text-align: center;
	            margin-bottom: 20px;
	            color: #343a40;
	        }
	        form {
	            width: 100%;
	            text-align: left;
	        }
	        input[type="text"], input[type="file"], textarea {
	            width: 100%;
	            padding: 8px;
	            border: 1px solid #ced4da;
	            border-radius: 4px;
	            box-sizing: border-box;
	            margin-bottom: 10px;
	        }
	        textarea {
	            resize: vertical;
	            height: 150px;
	        }
	    </style>
	    <script type="text/javascript">
	        function validateForm(form) {
	            if (form.reviewTitle.value.trim() === "") {
	                alert("제목을 입력하세요.");
	                form.reviewTitle.focus();
	                return false;
	            }
	            if (form.reviewContent.value.trim() === "") {
	                alert("내용을 입력하세요.");
	                form.reviewContent.focus();
	                return true;
	            }
	        }
	        function changeFile() {
	            document.getElementById("reviewOfileInput").click(); // 파일 선택 창 열기
	        }
	        function fileChanged(event) {
	            const fileInput = event.target;
	            const fileName = fileInput.files[0].name; // 새로운 파일 이름 가져오기
	            document.getElementById("existingFileText").innerText = fileName; // 표시된 파일 이름 변경
	            document.getElementById("deleteFileButton").disabled = true; // 삭제 버튼 비활성화
	            document.getElementById("deleteFile").value = "false"; // 삭제 상태 리셋
	        }
	        function deleteFileHandler() {
	            const confirmDelete = confirm("현재 파일을 삭제하시겠습니까?");
	            if (confirmDelete) {
	                document.getElementById("deleteFile").value = "true";
	                document.getElementById("existingFileText").innerText = "삭제 완료";
	                document.getElementById("deleteFileButton").disabled = true;
	                alert("파일이 삭제되었습니다.");
	            } else {
	                alert("파일 삭제가 취소되었습니다.");
	            }
	        }
	    </script>
	</head>
	<body>
	    <div class="container">
	        <h2>수정하기</h2>
	        <form name="editFrm" method="post" enctype="multipart/form-data" action="/Member/review/reviewEdit" onsubmit="return validateForm(this);">
	            <input type="hidden" name="reviewNum" value="${dto.reviewNum}" />
	            <input type="hidden" name="existingFile" value="${dto.reviewOfile}" />
	            <input type="hidden" name="deleteFile" id="deleteFile" value="false" />
	            <div class="mb-3">
	                <label for="userNick" class="form-label">작성자</label>
	                <input type="text" name="userNick" value="${userNick}" readonly />
	            </div>
	            <div class="mb-3">
	                <label for="reviewTitle" class="form-label">제목</label>
	                <input type="text" name="reviewTitle" value="${dto.reviewTitle}" />
	            </div>
	            <div class="mb-3">
	                <label for="reviewContent" class="form-label">내용</label>
	                <textarea name="reviewContent">${dto.reviewContent}</textarea>
	            </div>
	            <div class="mb-3">
				    <label for="reviewOfile" class="form-label">사진 등록 (jpeg, png, gif, bmp)</label>
				    <c:choose>
				        <c:when test="${dto.reviewOfile != null}">
				            <p id="existingFileText">${dto.reviewOfile}</p>
				            <button type="button" class="btn btn-success" id="changeFileButton" onclick="changeFile()">사진 변경</button>
				            <button type="button" class="btn btn-danger" id="deleteFileButton" onclick="deleteFileHandler()">사진 삭제</button>
				            <!-- 숨겨진 파일 입력 필드를 추가합니다 -->
				            <input type="file" name="reviewOfile" id="reviewOfileInput" style="display:none;" onchange="fileChanged(event)" accept="image/*" />
				        </c:when>
				        <c:otherwise>
				            <input type="file" name="reviewOfile" accept="image/*" />
				        </c:otherwise>
				    </c:choose>
				</div>
	            <div class="text-center">
	                <button type="submit" class="btn btn-warning">수정 완료</button>
	                <button type="reset" class="btn btn-danger">초기화</button>
	                <button type="button" class="btn btn-secondary" onclick="location.href='/Member/review/reviewList';">목록으로</button>
	            </div>
	        </form>
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