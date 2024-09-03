<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/adminheader.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글 작성 폼</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #343a40;
        }
        .header {
            display: flex;
            align-items: center;
            padding: 10px 100px;
            border-bottom: 1px solid #ddd;
            justify-content: space-between;
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

        /* 헤더푸터================================================================= */
        .container {
            max-width: 800px; /* 원하는 최대 너비로 설정 (예: 800px) */
            margin-top: 50px;
            padding: 0 15px; /* 좌우 여백 추가 */
        }
        .form-container {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
             margin: 0 auto;
            
        }
        .form-header {
            margin-bottom: 20px;
        }
        .form-footer {
            margin-top: 20px;
        }
        .img-preview {
            max-width: 100%; /* 이미지가 부모 요소의 너비를 초과하지 않도록 설정 */
            height: auto; /* 이미지의 높이는 너비에 비례하여 자동으로 조정 */
            margin-top: 10px;
            max-height: 100px; /* 이미지의 최대 높이를 설정 */
        }
        .content-area {
            border: 1px solid #ced4da;
            padding: 10px;
            border-radius: 4px;
            min-height: 300px;
            background-color: #fff;
            overflow-y: auto;
        }
        .content-area img {
        max-width: 100%; /* 이미지의 최대 너비를 부모 요소의 너비로 제한 */
        height: auto; /* 이미지의 높이를 자동으로 조정 */
        max-height: 200px; /* 이미지의 최대 높이를 제한 */
        display: block; /* 이미지의 상하 여백을 제거 */
        margin-top: 10px;
        margin-bottom: 10px;
    }
    </style>
    
    <script type="text/javascript">
		    function validateForm(form) {  // 필수 항목 입력 확인

		        if (form.promotion_title.value == "") {
		            alert("제목을 입력하세요.");
		            form.promotion_title.focus();
		            return false;
		        }
		        const contentDiv = document.getElementById('promotion_content');
		        if (contentDiv.innerHTML.trim() == "") {
		            alert("내용을 입력하세요.");
		            contentDiv.focus();
		            return false;
		        }
		    }
		</script>
</head>
<body>
<div class="container">
    <div class="form-container">
        <h2 class="form-header">게시글 작성하기</h2>
        <form name="writeFrm" method="post" enctype="multipart/form-data" action="/Admin/promotionWrite" onsubmit="return validateForm(this);">
          <div class="form-group">
		        <label for="user_nick">작성자</label>
		        <input type="text" class="form-control" id="userNick" name="userNick" value="${userNick}" readonly style="background-color: #e9ecef; cursor: not-allowed;"/>
		    </div>
            <div class="form-group">
                <label for="promotion_title">제목</label>
                <input type="text" class="form-control" id="promotion_title" name="promotion_title" placeholder="제목을 입력하세요"/>
            </div>
             <input type="hidden" id="promotion_content_hidden" name="promotion_content" />
              <div class="form-group">
                    <label for="promotion_content">내용</label>
                    <div id="promotion_content" class="content-area" contenteditable="true" placeholder="내용을 입력하세요"></div>
                </div>
            <div class="form-group">
                <label for="promotion_ofile">첨부 파일</label>
                <input type="file" class="form-control-file" id="promotion_ofile" name="promotion_ofile"/>
                <img id="imagePreview" class="img-preview" src="" alt="이미지 미리보기" style="display:none;"/>
            </div>
            <div class="form-footer">
                <button type="submit" class="btn btn-primary btn-custom">등록</button>
                <button type="button" class="btn btn-secondary btn-custom" onclick="location.href='/Admin/promotion/promotionList';">목록 바로가기</button>
            </div>
        </form>
    </div>
</div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- JavaScript for image preview and button functionality -->
      <script> 
      // 이미지 미리보기 기능
      document.getElementById('promotion_ofile').addEventListener('change', function(event) {
          const file = event.target.files[0];
          if (file) {
              const reader = new FileReader();
              reader.onload = function(e) {
                  const imagePreview = document.getElementById('imagePreview');
                  imagePreview.src = e.target.result;
                  imagePreview.style.display = 'block'; // 이미지 미리보기 보이기
                  insertImageIntoContent(e.target.result); // 콘텐츠에 이미지 삽입
              }
              reader.readAsDataURL(file);
          } else {
              document.getElementById('imagePreview').style.display = 'none'; // 이미지 미리보기 숨기기
          }
      });

   // 콘텐츠에 이미지를 삽입하는 함수
		function insertImageIntoContent(imageSrc) {
		    const contentDiv = document.getElementById('promotion_content');
		    const img = document.createElement('img');
		    img.src = imageSrc;
		    img.style.maxWidth = '100%';
		    img.style.height = 'auto';
		    contentDiv.appendChild(img);
		}
        
	    // 폼 제출 전에 contenteditable div의 내용을 숨겨진 필드에 복사
	    document.querySelector('form').addEventListener('submit', function() {
	        const contentDiv = document.getElementById('promotion_content');
	        const hiddenField = document.getElementById('promotion_content_hidden');
	        hiddenField.value = contentDiv.innerHTML; // contenteditable div의 내용을 숨겨진 입력 필드에 복사
	    });
    </script> 
    
    <br/><br/>

    <!-- 푸터================================================================================================= -->
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
