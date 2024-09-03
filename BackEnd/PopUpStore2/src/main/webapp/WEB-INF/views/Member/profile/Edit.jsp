<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>내정보 수정</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        
        <script>
	        var NickChk = 0;
	        function fn_NickCheck(){
	            var nick = $('#userNick').val();
	            
	            if (nick.length < 3 || nick.length > 10) {  
	                alert("닉네임은 3~10자 이내로 입력해주세요.");
	                return;
	            }
	            
	            $.ajax({
	                url: "/NickCheck",
	                type: "POST",
	                data: nick,
	                dataType : "json",
	                contentType : "application/json; charset=utf-8",
	                
	                success: function(data){
	                    if (data.cnt > 0){
	                        alert("이미 사용중인 닉네임입니다.");
	                        $('.btn btn-secondary w-100').addClass("has-error"); 
	                        $('.btn btn-secondary w-100').removeClass("has-success");
	                        $("#userNick").focus();
	                    } else {
	                        alert("사용가능한 닉네임입니다.")
	                        $('.btn btn-secondary w-100').addClass("has-success"); 
	                        $('.btn btn-secondary w-100').removeClass("has-error");
	                        $("#userNick").focus();
	                        NickChk = 1;
	                    }
	                },
	                error:function(error){
	                    alert("닉네임을 입력해주세요");
	                }
	            });
	        };
         
            var EmailChk = 0;
            function fn_EmailCheck(){
                var email = $('#userEmail').val();
                $.ajax({
                    url: "/EmailCheck",
                    type: "POST",
                    data: email,
                    dataType : "json",
                    contentType : "application/json; charset=utf-8",
                    
                    success: function(data){
                        if (data.cnt > 0){
                            alert("이미 사용중인 이메일입니다.");
                            $('.btn btn-secondary w-100').addClass("has-error"); 
                            $('.btn btn-secondary w-100').removeClass("has-success");
                            $("#userEmail").focus();
                        } else {
                            alert("사용가능한 이메일입니다.")
                            $('.btn btn-secondary w-100').addClass("has-success"); 
                            $('.btn btn-secondary w-100').removeClass("has-error");
                            $("#userEmail").focus();
                            EmailChk = 1;
                        }
                    },
                    error:function(error){
                        alert("이메일를 입력해주세요");
                    }
                });
            };
                 
            function combinePhone() {
                var phonePart1 = document.getElementById("userPhone1").value;
                var phonePart2 = document.getElementById("userPhone2").value;
                var phonePart3 = document.getElementById("userPhone3").value;
                var fullPhone = phonePart1 + phonePart2 + phonePart3;

                document.getElementById("userPhone").value = fullPhone;
            }
			
            var PhoneChk = 0;
            
            function fn_PhoneCheck() {
                combinePhone(); // 전화번호 결합
                var fullPhone = document.getElementById("userPhone").value;
                $.ajax({
                    url: "/PhoneCheck",
                    type: "POST",
                    data: fullPhone,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    
                    success: function(data) {
                        if (data.cnt > 0) {
                            alert("이미 사용중인 전화번호입니다.");
                            $('.btn.btn-secondary.w-100').addClass("has-error");
                            $('.btn.btn-secondary.w-100').removeClass("has-success");
                            $("#userPhone1").focus();
                        } else {
                            alert("사용가능한 전화번호입니다.");
                            $('.btn.btn-secondary.w-100').addClass("has-success");
                            $('.btn.btn-secondary.w-100').removeClass("has-error");
                            $("#userPhone1").focus();
                            PhoneChk = 1;
                        }
                    },
                    error: function(error) {
                        alert("전화번호를 입력해주세요");
                    }
                });
            }
                     
            function moveToNext(current, nextFieldId) {
                if (current.value.length >= current.maxLength) {
                    document.getElementById(nextFieldId).focus();
                }
            }
                     

            function validateForm() {
                combinePhone(); // 	
                var currentPwd = document.getElementById("currentPwd").value;
                var pwd = document.getElementById("userPwd").value;
                var pwdConfirm = document.getElementById("userPwdConfirm").value;
                var userNick = document.getElementById("userNick").value;
                var email = document.getElementById("userEmail").value;
                var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
                var phone = document.getElementById("userPhone").value;
                var address = document.getElementById("signup-address").value;
                
                if (!currentPwd) {
                    alert("현재 비밀번호를 입력해주세요.");
                    return false;
                }
                
                if (pwd !== pwdConfirm) {
                    alert("비밀번호가 일치하지 않습니다.");
                    return false;
                }
                
                if (!userNick && !pwd && !email && !phone && !address) {
                    alert("수정할 정보를 입력해주세요.");
                    return false;
                }
                
                // 기타 유효성 검사
               	alert("정보 수정이 완료 되었습니다!");
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
            <form class="signup-form" id="signup-form" method="post" action="/Member/profile/Update" onsubmit="return validateForm()">
			    <!-- Error message display -->
			    <c:if test="${not empty errorMessage}">
			        <div class="alert alert-danger">${errorMessage}</div>
			    </c:if>
			    <c:if test="${not empty successMessage}">
			        <div class="alert alert-success">${successMessage}</div>
			    </c:if>
				
				<input type="hidden" id="userId" name="userId" value="${userId}">
				
				<div class="mb-3 row">
				    <label for="userId" class="col-sm-3 col-form-label">아이디</label>
				    <div class="col-sm-6">
				        <input type="text" class="form-control" value="${userId}" readonly style="background-color: #e9ecef; cursor: not-allowed;">
				    </div>
				</div>
				
			    <div class="mb-3 row">
			        <label for="userNick" class="col-sm-3 col-form-label">닉네임</label>
			        <div class="col-sm-6">
			            <input type="text" class="form-control" id="userNick" name="userNick">
			            <small class="form-text text-muted">닉네임은 3~10자 이내로 입력해주세요.</small>
			            <form:errors path="userNick" cssClass="text-danger" />
			        </div>
			        <div class="col-sm-3">
			            <button type="button" onclick="fn_NickCheck();" id="NickCheck" class="btn btn-secondary w-100">중복 확인</button>
			        </div>
			    </div>
			
			    <div class="mb-3 row">
			        <label for="currentPwd" class="col-sm-3 col-form-label">현재 비밀번호</label>
			        <div class="col-sm-6">
			            <input type="password" class="form-control" id="currentPwd" name="currentPwd" required>
			            <form:errors path="currentPwd" cssClass="text-danger" />
			        </div>
			    </div>
				
				<div class="mb-3 row">
			        <label for="userPwd" class="col-sm-3 col-form-label">새 비밀번호</label>
			        <div class="col-sm-6">
			            <input type="password" class="form-control" id="userPwd" name="userPwd">
			            <small class="form-text text-muted" style="white-space: nowrap;">비밀번호는 8~20자 이내로 입력해주세요.</small>
			            <form:errors path="userPwd" cssClass="text-danger" />
			        </div>
			    </div>
			
			    <div class="mb-3 row">
				    <label for="signup-pwd-confirm" class="col-sm-3 col-form-label" style="white-space: nowrap;">새 비밀번호 확인</label>
				    <div class="col-sm-6">
				        <input type="password" class="form-control" id="userPwdConfirm" name="userPwdConfirm">
				        <form:errors path="userPwdConfirm" cssClass="text-danger" />
				    </div>
				</div>
			
			    <div class="mb-3 row">
			        <label for="userPhone" class="col-sm-3 col-form-label">전화 번호</label>
			        <div class="col-sm-6 d-flex align-items-center">
			            <input type="text" class="form-control" id="userPhone1" name="userPhone1" maxlength="3"
			                   pattern="\d{3}" title="숫자 3자리 입력" style="width: 25%;" oninput="moveToNext(this, 'userPhone2')">
			            <span class="mx-2" style="font-size: 1.5rem; line-height: 1;">-</span>
			            <input type="text" class="form-control" id="userPhone2" name="userPhone2" maxlength="4" 
			                   pattern="\d{4}" title="숫자 4자리 입력" style="width: 30%;" oninput="moveToNext(this, 'userPhone3')">
			            <span class="mx-2" style="font-size: 1.5rem; line-height: 1;">-</span>
			            <input type="text" class="form-control" id="userPhone3" name="userPhone3" maxlength="4" 
			                   pattern="\d{4}" title="숫자 4자리 입력" style="width: 30%;">
			            <!-- 실제로 서버에 전송될 폰 번호 -->
			            <input type="hidden" id="userPhone" name="userPhone" value="">
			        </div>
			        <form:errors path="userPhone" cssClass="text-danger" />
			        <div class="col-sm-3">
			            <button type="button" onclick="fn_PhoneCheck();" id="PhoneCheck" class="btn btn-secondary w-100">중복 확인</button>
			        </div>
			    </div>
			
			    <div class="mb-3 row">
			        <label for="userEmail" class="col-sm-3 col-form-label">이메일</label>
			        <div class="col-sm-6">
			            <input type="email" class="form-control" id="userEmail" name="userEmail">
			            <form:errors path="userEmail" cssClass="text-danger" />
			        </div>
			        <div class="col-sm-3">
			            <button type="button" onclick="fn_EmailCheck();" id="EmailCheck" class="btn btn-secondary w-100">중복 확인</button>
			        </div>
			    </div>
			
			    <div class="mb-3 row">
			        <label for="signup-postcode" class="col-sm-3 col-form-label" id="userZipcode" name="userZipcode">우편번호</label>
			        <div class="col-sm-6">
			            <input type="text" class="form-control" id="signup-postcode" name="userZipcode">
			        </div>
			        <div class="col-sm-3">
			            <button type="button" class="btn btn-secondary w-100" onclick="sample6_execDaumPostcode()">주소 찾기</button>
			        </div>
			    </div>
			
			    <div class="mb-3 row">
			        <label for="signup-address" class="col-sm-3 col-form-label">주소</label>
			        <div class="col-sm-6">
			            <input type="text" class="form-control" id="signup-address" name="userAddress">
			        </div>
			    </div>
			
			    <div class="mb-3 row">
			        <label for="signup-address-detail" class="col-sm-3 col-form-label">상세 주소</label>
			        <div class="col-sm-6">
			            <input type="text" class="form-control" id="signup-address-detail" name="userAddressDetail">
			        </div>
			    </div>
			
			    <div class="text-center">
			        <button type="submit" class="btn btn-secondary w-100">정보수정</button>
			    </div>
			    <div class="text-end mt-2">
				    <a href="/Member/profile/Withdraw?userId=${userId}" style="color: black; font-size: 12px; text-decoration: none;">회원탈퇴</a>
				</div>
			</form>
        </div>

        <!-- 서버에서 전달된 오류 메시지를 alert 창으로 표시 -->
        <c:if test="${not empty errorMessage}">
            <script>
                alert("${errorMessage}");
            </script>
        </c:if>
        
        <c:if test="${not empty errMessages}">
        <div class="alert alert-danger">
            <ul>
                <c:forEach var="error" items="${errMessages}">
                    <li>${error.defaultMessage}</li>
                </c:forEach>
            </ul>
        </div>
        </c:if>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <script>
            function sample6_execDaumPostcode() {
                new daum.Postcode({
                    oncomplete: function(data) {
                        var addr = '';
                        var extraAddr = '';

                        if (data.userSelectedType === 'R') {
                            addr = data.roadAddress;
                        } else {
                            addr = data.jibunAddress;
                        }

                        if(data.userSelectedType === 'R'){
                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                extraAddr += data.bname;
                            }
                            if(data.buildingName !== '' && data.apartment === 'Y'){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            if(extraAddr !== ''){
                                extraAddr = ' (' + extraAddr + ')';
                            }
                        }

                        document.getElementById('signup-postcode').value = data.zonecode;
                        document.getElementById("signup-address").value = addr + extraAddr;
                        document.getElementById("signup-address-detail").focus();
                    }
                }).open();
            }
            
        </script>
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
