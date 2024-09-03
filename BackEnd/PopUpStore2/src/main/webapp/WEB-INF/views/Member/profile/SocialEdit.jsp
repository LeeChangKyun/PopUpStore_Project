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
                combinePhone(); // 폼 제출 전에 전화번호를 결합
                
             	// PhoneChk 확인
                if (PhoneChk !== 1) {
                    alert("전화번호 중복 확인을 해주세요.");
                    return false;
                }
                
                // 기타 유효성 검사
                return true;
            }
             
            function confirmWithdraw() {
                // 첫 번째 alert 창: 회원탈퇴 확인
                if (confirm("정말 탈퇴하시겠습니까?")) {
                    // 탈퇴 확인 후, 두 번째 alert 창을 위해 서버에 요청을 보냄
                    $.post("/Member/profile/SocialWithdraw", { userId: "${userId}", socialProvider: "${socialProvider}" })
                        .done(function() {
                            alert("그동안 이용해주셔서 감사합니다. 탈퇴 되었습니다!"); // 두 번째 alert 창
                            window.location.href = "/"; // 홈으로 리다이렉트
                        })
                        .fail(function() {
                            alert("회원 탈퇴에 실패했습니다."); // 실패 시 알림
                        });
                }
            }
            
        </script>
        
        
        <style>
            body {
                font-family: Verdana, Geneva, Tahoma, sans-serif;
                margin: 0;
                background-color: #343a40;
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
			
		    .phone-input {
		        padding-left: 2px;
		        padding-right: 2px;
		        text-align: center;
		        box-sizing: border-box;
		    }
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
    		
    .header {
            /* 헤더를 고정하고 상단에 배치하며, 다른 요소 위에 위치하도록 z-index 설정 */
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color:#fff !important; /* 헤더 배경색을 어두운 회색으로 설정 */
            border: none; /* 헤더의 테두리 제거 */
            
            top: 0;
            left: 0;
            width: 100%;
            height: 70px; /* 헤더 높이 설정 */
            box-sizing: border-box;
        }

		.nav {	
            /* 내비게이션 바의 항목들을 가로로 배치하고, 간격을 설정하며, 중앙에 정렬 */
            display: flex;
            gap: 50px;
            align-items: center;
            justify-content: center;
            flex-grow: 1;
        }

        .nav a, .nav .dropdown-toggle {
            /* 내비게이션 링크와 드롭다운 버튼의 스타일 설정: 텍스트 색상, 폰트 크기, 중앙 정렬 */
            text-decoration: none;
            color: #4e4f4e;
            font-size: 16px;
            position: relative;
            background: none;
            display: flex;
            align-items: center;
            line-height: 1.5;
            letter-spacing: 0.5px;
        }

        .nav .dropdown-menu {
            /* 드롭다운 메뉴의 초기 상태를 숨김, 위치를 절대적으로 설정 */
            display: none;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
            top: 100%;
            z-index: 1000;
        }

        .nav .dropdown-menu.show {
            /* 드롭다운 메뉴가 표시되었을 때 display를 block으로 변경 */
            display: block;
        }

        .nav a:last-child {
            /* 내비게이션의 마지막 링크를 왼쪽으로 조금 이동 */
            margin-left: -5px;
        }

        .nav a.beta {
            /* beta 링크의 색상, 배경색, 여백 및 둥근 모서리 설정 */
            color: #2196F3;
            background-color: #E3F2FD;
            padding: 3px 5px;
            border-radius: 3px;
        }

        .nav .dropdown-toggle {
            /* 드롭다운 버튼의 테두리 색상 및 그림자 제거 */
            outline: none;
            box-shadow: none;
            border-color: transparent;
        }

        .nav .dropdown-toggle:hover {
            /* 드롭다운 버튼에 마우스를 올렸을 때 텍스트 색상을 파란색으로 변경 */
            color: #2196F3;
        }

        .auth {
            /* 인증 섹션의 항목들을 가로로 배치하고, 간격을 설정 */
            display: flex;
            gap: 15px;
            margin-left: 80px;
        }

        .auth a {
            /* 인증 링크의 스타일 설정: 텍스트 색상, 폰트 크기, 중앙 정렬 */
            text-decoration: none;
            color:#4e4f4e;
            font-size: 16px;
            display: flex;
            align-items: center;
        }

        .auth button {
            /* 인증 버튼의 배경 및 테두리 제거, 마우스 커서를 포인터로 설정 */
            background: none;
            border: none;
            padding: 0;
            cursor: pointer;
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
		
		/* 푸터 내비게이션 스타일 */
		footer .footer-nav {
		    display: flex;
		    justify-content: center;
		    gap: 20px;
		    margin-bottom: 10px;
		}
		
		/* 푸터 내비게이션 링크 스타일 */
		footer .footer-nav a {
		    text-decoration: underline;
		    color: #000; /* 흰색 배경에 맞는 색상 설정 */
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
            
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <form class="signup-form" id="signup-form" method="post" action="/Member/profile/SocialUpdate" onsubmit="return validateForm()">
				
				<!-- Error message display -->
			    <c:if test="${not empty errorMessage}">
			        <div class="alert alert-danger">${errorMessage}</div>
			    </c:if>
			    <c:if test="${not empty successMessage}">
			        <div class="alert alert-success">${successMessage}</div>
			    </c:if>
				
                <div class="mb-3 row">
                    <label for="userNick" class="col-sm-3 col-form-label">닉네임</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="userNick" name="userNick" required>
                        <small class="form-text text-muted">닉네임은 3~10자 이내로 입력해주세요.</small>
                        <form:errors path="userNick" cssClass="text-danger" />
                    </div>
                    <div class="col-sm-3">
                        <button type="button" onclick="fn_NickCheck();" id="NickCheck" class="btn btn-secondary w-100">중복 확인</button>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="signup-name" class="col-sm-3 col-form-label">이름</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="signup-name" name="userName" required>
                    </div>
                </div>

                <div class="mb-3 row">
				    <label for="userPhone" class="col-sm-3 col-form-label">전화 번호</label>
				    <div class="col-sm-6 d-flex align-items-center">
				        <input type="text" class="form-control phone-input" id="userPhone1" name="userPhone1" maxlength="3" required
				               pattern="\d{3}" title="숫자 3자리 입력" style="width: 25%;" oninput="moveToNext(this, 'userPhone2')">
				        <span class="mx-2" style="font-size: 1.5rem; line-height: 1;">-</span>
				        <input type="text" class="form-control phone-input" id="userPhone2" name="userPhone2" maxlength="4" required
				               pattern="\d{4}" title="숫자 4자리 입력" style="width: 30%;" oninput="moveToNext(this, 'userPhone3')">
				        <span class="mx-2" style="font-size: 1.5rem; line-height: 1;">-</span>
				        <input type="text" class="form-control phone-input" id="userPhone3" name="userPhone3" maxlength="4" required
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
                    <label for="signup-postcode" class="col-sm-3 col-form-label" id="userZipcode" name="userZipcode">우편번호</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="signup-postcode" name="userZipcode" required>
                    </div>
                    <div class="col-sm-3">
                        <button type="button" class="btn btn-secondary w-100" onclick="sample6_execDaumPostcode()">주소 찾기</button>
                    </div>
                </div>
				
                <div class="mb-3 row">
                    <label for="signup-address" class="col-sm-3 col-form-label">주소</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="signup-address" name="userAddress" required>
                    </div>
                </div>

                <div class="mb-3 row">
                    <label for="signup-address-detail" class="col-sm-3 col-form-label">상세 주소</label>
                    <div class="col-sm-6">
                        <input type="text" class="form-control" id="signup-address-detail" name="userAddress" required>
                    </div>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-secondary w-100">수정하기</button>
                </div>
                <div class="text-end mt-2">
    				<a href="javascript:void(0);" onclick="confirmWithdraw();" style="color: black; font-size: 12px; text-decoration: none;">회원탈퇴</a>
				</div>
            </form>

        </div>

        <c:if test="${not empty successMessage}">
		    <script>
		        alert("${successMessage}");
		        window.location.href = "/";  // 성공 후 리다이렉트할 URL
		    </script>
		</c:if>
		
		<c:if test="${not empty errorMessage}">
		    <script>
		        alert("${errorMessage}");
		        window.location.href = "/Member/profile/SocialEdit";  // 실패 시 돌아갈 URL
		    </script>
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
