<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <style>
        /* 폰트 정의 */
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

        /* SVG 아이콘 드롭다운 위치 수정 */
        .auth .dropdown-menu {
            right: 0; /* 오른쪽으로 정렬 */
            left: auto; /* 기본값은 왼쪽이므로 오른쪽으로 이동 */
        }
        /* SVG 아이콘 호버 색상 변경 */
        .auth .dropdown-toggle:hover svg {
            fill: #2196F3; /* SVG 아이콘의 색상 변경 */
        }

        body {
            font-family: Verdana, Geneva, Tahoma, sans-serif;
            margin: 0;
            background-color: #343a40;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: whitesmoke;
            padding: 30px; /* 패딩을 증가시켜 더 넓게 보이도록 설정 */
            border-radius: 10px;
            max-width: 500px; /* 컨테이너의 최대 너비를 넓게 설정 */
            width: 100%;
            text-align: center;
        }

        .logo {
            margin-bottom: 40px; /* 로고와 로그인 폼 사이의 간격을 증가 */
            font-size: 24px;
            color: #343a40;
        }

        .login-form {
            margin-top: 30px; /* 로그인 폼 상단에 여백 추가 */
        }

        .mb-3 {
            margin-bottom: 15px;
        }

        .login-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            color: white;
            background-color: #343a40;
            cursor: pointer;
            width: 100%;
        }

        .social-login {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 15px; /* 아이콘 간의 간격을 조정합니다 */
        }

        .social-login img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            transition: transform 0.2s;
        }

        .social-login img:hover {
            transform: scale(1.1);
        }

        .links {
            color: black;
            margin-top: 20px;
            font-size: 14px;
        }

        .links a {
            color: black;
            text-decoration: none;
            margin: 0 10px;
        }

        .links a:hover {
            text-decoration: underline;
        }
    </style>

    <script>
    document.addEventListener("DOMContentLoaded", function() {
        console.log("페이지 로드됨");

        const urlParams = new URLSearchParams(window.location.search);
        
        // 회원가입 성공 시 알림
        if (urlParams.get('success') === 'true') {
            alert("회원가입이 완료되었습니다!!! 가입해주셔서 감사합니다 ㅎ.ㅎ");
        }

        // 로그인 실패 시 알림
        if (urlParams.get('error') === 'true') {
            alert("로그인에 실패했습니다. 아이디나 비밀번호를 확인해주세요.");
        }
    });
    
    </script>
</head>
<body>
    <div class="container mt-5">
        <div class="login-page">
            <h2 class="example-text brand-font-700 centered-text">
		        <a href="/" style="color: #4e4f4e; text-decoration: none;">PopUpStore</a>
		    </h2>
            <form class="login-form" id="login-form" method="post" action="/Login">
                <div class="mb-3">
                    <label for="login-id" class="form-label">아이디</label>
                    <input type="text" class="form-control" id="login-id" name="userName" required>
                </div>
                <br />
                <div class="mb-3">
                    <label for="login-pwd" class="form-label">비밀번호</label>
                    <input type="password" class="form-control" id="password" name="userPwd" required>
                </div>
                <br />
                <div class="d-grid gap-2">    
                    <button type="submit" class="btn btn-secondary login-btn">로그인</button>
                </div>
            </form>
            
            <!-- 소셜 로그인 버튼들 -->
            <div class="social-login mt-4">
                <!-- Google 로그인 버튼 -->
                <a href="${pageContext.request.contextPath}/oauth2/authorization/google">
                    <img src="<%=request.getContextPath()%>/image/Google.png" alt="Google">
                </a>
                
                <!-- Naver 로그인 버튼 -->
                <a href="${pageContext.request.contextPath}/oauth2/authorization/naver">
                    <img src="<%=request.getContextPath()%>/image/Naver.png" alt="Naver">
                </a>
                
                <!-- Kakao 로그인 버튼 -->
                <a href="${pageContext.request.contextPath}/oauth2/authorization/kakao">
                    <img src="<%=request.getContextPath()%>/image/Kakao.png" alt="Kakao">
                </a>
            </div>

            <div class="text-center mt-3 links">
                <a href="/FindIdPw">아이디 / 비밀번호 찾기</a> 
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a href="/register_form">회원가입</a>
            </div>
        </div>
    </div>  

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>