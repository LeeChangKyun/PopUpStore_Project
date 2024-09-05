<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Common/header.jsp" %> <!-- 헤더 파일 포함 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>계정 인증</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <style>
    
    
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
             max-width: 500px;
             width: 100%;
             margin-bottom: 100px;
         }

         .find-page {
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

         .header h2{
             white-space: nowrap;
         }

         .logo {
             background-color: #343a40;
             padding: 20px;
             border-radius: 5px;
             margin-bottom: 20px;
             font-size: 20px;
             color: aliceblue;
         }

         .input-group {
             display: flex;
             align-items: center;
             margin-bottom: 10px;
         }

         .input-group label {
             width: 100px;
             text-align: right;
             margin-right: 10px;
         }

         .input-group input[type="text"],
         .input-group input[type="email"],
         .input-group input[type="password"],
         .input-group input[type="tel"],
         .input-group select {
             flex: 1;
             padding: 5px;
             border: 1px solid black;
             box-sizing: border-box;
         }

         .input-group.button-group {
             display: flex;
             justify-content: center;
             gap: 10px;
             margin-bottom: 20px;
         }

         .input-group button {
             padding: 5px 10px;
             border: none;
             border-radius: 5px;
             background-color: lightcoral;
             color: white;
             cursor: pointer;
         }

         .input-group button:hover {
             background-color: darkred;
         }

         .action-group {
             text-align: center;
             margin-top: 20px;
         }
	
.nav-tabs .nav-link {
    color: black; /* 탭 텍스트 색상 검정으로 변경 */
}

.nav-tabs .nav-link.active {
    color: black; /* 활성화된 탭 텍스트 색상도 검정으로 유지 */
    background-color: #f8f9fa; /* 활성화된 탭 배경색 (선택 사항) */
}

.text-center a {
    color: black; /* 로그인 페이지로 돌아가기 링크 색상 검정으로 변경 */
}

.text-center a:hover {
    text-decoration: underline;
    color: darkred; /* 선택사항: 호버 시 색상 변경 */
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

         footer {
			 padding: 10px;
			 text-align: center;
			 background-color: #fff;
			 border-top: none;
			 width: 100%;
			 box-sizing: border-box; /* 패딩을 너비에 포함시킴 */
			 position: fixed; /* 페이지 하단에 고정 */
			 bottom: 0;
			 left: 0;
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
         
         --------------------------------------------------------
         
    </style>

    <script>
	    $(document).ready(function () {
	        $('#send-auth-code').click(function () {
	            var userName = $('#find-password-name').val();
	            var userEmail = $('#find-id-email').val();
	
	            if (!userName) {
	                alert('이름을 입력해주세요.');
	                return;
	            }
	
	            if (!userEmail) {
	                alert('이메일을 입력해주세요.');
	                return;
	            }
	
	            $.ajax({
	                type: 'POST',
	                url: '/emailCheck',
	                contentType: 'application/json',
	                dataType: 'json',
	                data: JSON.stringify({ 
	                    name: userName, 
	                    email: userEmail 
	                }),
	                success: function (response) {
	                    if (response.match === true) {
	                        alert('인증번호가 발송되었습니다.');
	                        $('#auth-code-section').show();
	                        $('#auth-code').prop('disabled', false);
	                    } else {
	                        alert('이름 및 이메일을 확인해주세요.');
	                    }
	                },
	                error: function (xhr, status, error) {
	                    console.error('Error:', error);
	                    alert('메일 발송 중 오류가 발생했습니다. 다시 시도해주세요.');
	                }
	            });
	        });
	
	        $('#verify-auth-code').click(function () {
	            var authCode = $('#auth-code').val().trim();

	            console.log("Auth Code Sent: " + authCode);

	            if (!authCode) {
	                alert('인증번호를 입력해주세요.');
	                return;
	            }

	            $.ajax({
	                type: 'POST',
	                url: '/AuthCode',
	                contentType: 'application/json',
	                dataType: 'json',
	                data: JSON.stringify({ authCode: authCode }),
	                success: function (response) {
	                    console.log("Server response:", response); // 추가 디버깅
	                    console.log("Type of response.verified:", typeof response.verified); // 타입 확인
	                    if (response.verified == true || response.verified === "true") {  // == 를 사용하여 문자열 "true"도 허용
	                        alert('인증이 완료되었습니다. 임시 비밀번호가 이메일로 발송되었습니다.');
	                        $('#temp-password-section').show();
	                        window.location.href = '/Guest/auth/Login';
	                    } else {
	                        alert('인증번호가 일치하지 않습니다.');
	                    }
	                },
	                error: function (xhr, status, error) {
	                	console.error('AJAX Request Failed');
	                    console.error('Error:', error);
	                    console.error('Status:', status);
	                    console.error('Response:', xhr.responseText);
	                    alert('인증 중 오류가 발생했습니다. 다시 시도해주세요.');
	                }
	            });
	        });
	    });
	    
	    window.onload = function() {
	        alert("계정이 비활성화 되었습니다. 인증 처리 후 계정이 활성화됩니다.");
	    };
	    
    </script>

	</head>
	<body>
		<div class="container mt-5">
		    <div class="find-page">
		        <div class="tab-content" id="findTabContent">
		            <div class="tab-pane fade show active" id="find-id" role="tabpanel" aria-labelledby="find-id-tab">
		                <form class="find-form mt-3" id="find-password-form">
		                    <div class="mb-3">
		                        <label for="find-password-name" class="form-label">이름</label>
		                        <input type="text" class="form-control" id="find-password-name" required>
		                    </div>
		                    <div class="mb-3" id="email-section">
		                        <label for="find-id-email" class="form-label">이메일</label>
		                        <div class="input-group">
								    <input type="email" class="form-control" id="find-id-email" required>
								    <button type="button" class="btn" id="send-auth-code" style="background-color: #6c757d; color: white; border-color: #6c757d; height: 38px; margin-left: 10px;">인증번호 발송</button>
								</div>
		                    </div>
		                    <div class="mb-3" id="auth-code-section" style="display:none;">
		                        <label for="auth-code" class="form-label">인증번호</label>
		                        <input type="text" class="form-control" id="auth-code" required>
		                        <button type="button" class="btn btn-secondary mt-2" id="verify-auth-code">인증번호 확인</button>
		                    </div>
		                    <div class="d-grid gap-2" id="temp-password-section" style="display:none;">
		                        <button type="submit" class="btn btn-secondary mt-2">다음</button>
		                    </div>
		                </form>
		            </div>
		        </div>
		        <div class="text-center mt-3">
		            <a href="/Guest/auth/Login">로그인 페이지로 돌아가기</a>
		        </div>
		    </div>
		</div>
	
	<%@ include file="/WEB-INF/views/Common/footer.jsp" %>
	
	<script>
	    const dropdowns = document.querySelectorAll('.dropdown');
	
	    dropdowns.forEach(dropdown => {
	        dropdown.addEventListener('mouseenter', () => {
	            dropdown.querySelector('.dropdown-menu').classList.add('show');
	        });
	
	        dropdown.addEventListener('mouseleave', () => {
	            dropdown.querySelector('.dropdown-menu').classList.remove('show');
	        });
	    });
	</script>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	</body>
</html>
