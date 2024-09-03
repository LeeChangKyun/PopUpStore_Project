<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>회원 탈퇴</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        
        <script>
	        function validateForm() {
	            var pwd = document.getElementById("userPwd").value;
	            var pwdConfirm = document.getElementById("userPwdConfirm").value;
	            
	            if (pwd === "") {
	                alert("비밀번호를 입력하세요.");
	                return false;
	            }
	            
	            if (pwd !== pwdConfirm) {
	                alert("비밀번호가 일치하지 않습니다.");
	                return false;
	            }
				
	            alert("그동안 이용해주셔서 감사합니다 회원탈퇴 되었습니다!");
	            return true;
	        }
        </script>
        
        
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
            -------------------------------------------------------
            body {
                font-family: Verdana, Geneva, Tahoma, sans-serif;
                margin: 0;
                background-color: #343a40;
                display: flex;
                flex-direction: column;
                align-items: center;
                min-height: 100vh;
            }

            .container {
                background-color: whitesmoke;
                padding: 20px;
                border-radius: 10px;
                max-width: 520px;
                width: 100%;
                margin-bottom: 100px;
            }

            .signup-page {
                text-align: center;
                width: 100%;
            }

            .header {
                background-color: black;
                padding: 10px;
                border-radius: 5px;
                margin-bottom: 20px;
                color: white;
                font-size: 20px;
                width: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .logo {
                background-color: #343a40;
                padding: 20px;
                border-radius: 5px;
                margin-bottom: 20px;
                font-size: 20px;
                color: aliceblue;
            }

            .signup-form .input-group {
                display: flex;
                align-items: center;
            }

            .signup-form .input-group label {
                width: 120px; 
                text-align: right;
            }

            .signup-form .input-group input[type="text"],
            .signup-form .input-group input[type="email"],
            .signup-form .input-group input[type="password"],
            .signup-form .input-group input[type="tel"],
            .signup-form .input-group select {
                padding: 5px;
                border: 1px solid lightgray;
                width: calc(80% - 180px);
            }


            .signup-form .social-icons {
                display: flex;
                justify-content: center;
                gap: 10px;
            }

            .signup-form .social-icons button.naver {
                background-color: #03C75A;
            }

            .signup-form .social-icons button.kakao {
                background-color: #FEE500;
            }

            .signup-form .social-icons button.google {
                background-color: #f08080;
            }

            .signup-form .social-icons button.facebook {
                background-color: #4267B2;
            }

            .signup-form .social-icons button {
                padding: 10px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            .signup-form .social-icons img {
                width: 20px;
                height: 20px;
            }

            .action-group {
                text-align: center;
                margin-top: 20px;
            }

            .links {
                text-align: center;
                margin-top: 20px;
            }

            .links a {
                color: blue;
                text-decoration: none;
                margin: 0 5px;
            }

            .links a:hover {
                text-decoration: underline;
            }
            
            .text-center a {
			    color: black; /* 로그인 페이지로 돌아가기 링크 색상 검정으로 변경 */
			}
			
			.text-center a:hover {
			    text-decoration: underline;
			    color: darkred; /* 선택사항: 호버 시 색상 변경 */
			}
		    
		    .form-text {
			    white-space: nowrap;
			    overflow: visible;
			}

            footer {
                width: 100%;
                background-color: black;
                color: white;
                padding: 10px 0;
                text-align: center;
                position: relative;
                bottom: 0;
                left: 0;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
			<form class="signup-form" id="signup-form" method="post" action="/Member/profile/Withdraw" onsubmit="return validateForm()">
				<input type="hidden" id="userId" name="userId" value="${userId}">
				<div class="mb-3 row">
				    <label for="userId" class="col-sm-3 col-form-label">아이디</label>
				    <div class="col-sm-6">
				        <input type="text" class="form-control" value="${userId}" readonly style="background-color: #e9ecef; cursor: not-allowed;">
				    </div>
				</div>
				
			    <input type="hidden" id="userNick" name="userNick" value="${userNick}">
			    
				<div class="mb-3 row">
				    <label for="userNick" class="col-sm-3 col-form-label">닉네임</label>
				    <div class="col-sm-6">
				        <input type="text" class="form-control" id="userNick" name="userNick" value="${userNick}" readonly style="background-color: #e9ecef; cursor: not-allowed;">
				    </div>
				</div>
			
			    <div class="mb-3 row">
			        <label for="userPwd" class="col-sm-3 col-form-label">비밀번호</label>
			        <div class="col-sm-6">
			            <input type="password" class="form-control" id="userPwd" name="userPwd">
			            <form:errors path="userPwd" cssClass="text-danger" />
			        </div>
			    </div>
			
			    <div class="mb-3 row">
			        <label for="signup-pwd-confirm" class="col-sm-3 col-form-label">비밀번호 확인</label>
			        <div class="col-sm-6">
			            <input type="password" class="form-control" id="userPwdConfirm" name="userPwdConfirm">
			            <form:errors path="userPwdConfirm" cssClass="text-danger" />
			        </div>
			    </div>
			
				<input type="hidden" id="userPhone" name="userPhone" value="${userPhone}">

				<div class="mb-3 row">
				    <label for="userPhone" class="col-sm-3 col-form-label">전화 번호</label>
				    <div class="col-sm-6 d-flex align-items-center">
				        <input type="text" class="form-control" id="userPhone1" name="userPhone1" maxlength="3"
				               value="${fn:substring(userPhone, 0, 3)}" readonly style="background-color: #e9ecef; cursor: not-allowed; width: 30%;">
				        <span class="mx-2" style="font-size: 1.5rem; line-height: 1;">-</span>
				        <input type="text" class="form-control" id="userPhone2" name="userPhone2" maxlength="4"
				               value="${fn:substring(userPhone, 3, 7)}" readonly style="background-color: #e9ecef; cursor: not-allowed; width: 35%;">
				        <span class="mx-2" style="font-size: 1.5rem; line-height: 1;">-</span>
				        <input type="text" class="form-control" id="userPhone3" name="userPhone3" maxlength="4"
				               value="${fn:substring(userPhone, 7, 11)}" readonly style="background-color: #e9ecef; cursor: not-allowed; width: 35%;">
				    </div>
				</div>
			
			    <input type="hidden" id="userEmail" name="userEmail" value="${userEmail}">
	
				<div class="mb-3 row">
				    <label for="userNick" class="col-sm-3 col-form-label">이메일</label>
				    <div class="col-sm-6">
				        <input type="text" class="form-control" id="userEmail" name="userEmail" value="${userEmail}" readonly style="background-color: #e9ecef; cursor: not-allowed;">
				    </div>
				</div>
			
			    <div class="text-center">
			        <button type="submit" class="btn btn-secondary w-100">회원탈퇴</button>
			    </div>
			</form>
        </div>
        <%@ include file="/WEB-INF/views/Common/footer.jsp" %>
    </body>
</html>
