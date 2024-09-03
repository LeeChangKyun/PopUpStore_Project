<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/Common/header.jsp" %> <!-- 헤더 파일 포함 -->
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>아이디/비밀번호 찾기</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
        <style>
        
        .body {
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
            /* 헤더를 고정하고 상단에 배치하며, 다른 요소 위에 위치하도록 z-index 설정 */
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color: #343a40; /* 헤더 배경색을 어두운 회색으로 설정 */
            border: none; /* 헤더의 테두리 제거 */
            
            top: 0;
            left: 0;
            width: 100%;
            height: 70; /* 헤더 높이 설정 */
            box-sizing: border-box;
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

		}
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
	           
            --------------------------------------------------------
            
		
		
		
        
        </style>
        
        <script>
        $(document).ready(function() {
            $('#find-id-form').on('submit', function(e) {
                e.preventDefault();

                var name = $('#find-id-name').val();
                var phone = $('#find-id-phone').val();

                $.ajax({
                    type: 'GET',
                    url: 'FindId',
                    data: {
                        name: name,
                        phone: phone
                    },
                    success: function(response) {
                        if (response.status === 'success') {
                            alert('아이디는 ' + response.userId + ' 입니다.');
                        } else {
                            alert('해당 정보로 찾을 수 있는 아이디가 없습니다.');
                        }
                    },
                    error: function() {
                        alert('아이디 찾기에 실패했습니다. 다시 시도해주세요.');
                    }
                });
            });
        });
        
        $(document).ready(function() {
            // Next 버튼 클릭 시 폼 제출
            $('#get-temp-password').on('click', function() {
                $('#find-password-form').submit();  // 폼 제출
            });
        });
        
        
        $(document).ready(function() {
            $('#find-password-form').on('submit', function(event) {
                event.preventDefault(); // 폼의 기본 제출 동작 막기

                var userId = $('#find-password-id').val();
                console.log('User ID:', userId);

                // 아이디 유효성 확인을 위한 AJAX 요청
                $.ajax({
                    type: 'POST',
                    url: '/CheckUserId',
                    data: {
                        userId: userId
                    },
                    success: function(response) {
                        console.log('AJAX 응답:', response); // 응답 내용을 출력
                        if (response.status === 'exists') {
                            console.log('User ID exists. Submitting form.');
                            // 유효성 검사가 통과된 경우에만 폼 제출
                            $('#find-password-form').off('submit').submit(); // off()로 기존 이벤트 핸들러 제거 후 폼 제출
                        } else {
                            console.log('User ID does not exist.');
                            alert('일치하는 아이디가 없습니다.');
                        }
                    },
                    error: function(xhr, status, error) {
                        alert('아이디 확인 중 오류가 발생했습니다. 다시 시도해주세요.');
                    }
                });
            });
        });
        
        
        </script>
        
        
    </head>
    <body>
        <div class="container mt-5">
            <div class="find-page">
                <ul class="nav nav-tabs" id="findTab" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="find-id-tab" data-bs-toggle="tab" data-bs-target="#find-id" type="button" role="tab" aria-controls="find-id" aria-selected="true">아이디 찾기</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="find-password-tab" data-bs-toggle="tab" data-bs-target="#find-password" type="button" role="tab" aria-controls="find-password" aria-selected="false">비밀번호 찾기</button>
                    </li>
                </ul>
                <div class="tab-content" id="findTabContent">
                    <div class="tab-pane fade show active" id="find-id" role="tabpanel" aria-labelledby="find-id-tab">
                        <form class="find-form mt-3" id="find-id-form">
                            <div class="mb-3">
                                <label for="find-id-name" class="form-label">이름</label>
                                <input type="text" class="form-control" id="find-id-name" required>
                            </div>
                            <div class="mb-3">
                                <label for="find-id-phone" class="form-label">전화 번호</label>
                                <input type="tel" class="form-control" id="find-id-phone" required>
                            </div>
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-secondary">아이디 찾기</button>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane fade" id="find-password" role="tabpanel" aria-labelledby="find-password-tab">
						<form class="find-form mt-3" id="find-password-form" action="/FindPwAuth" method="post">
					        <div class="mb-3">
					            <label for="find-password-id" class="form-label">아이디</label>
					            <input type="text" class="form-control" id="find-password-id" required>
					        </div>
					        <div class="mb-3" id="email-section" style="display:none;">
					            <label for="find-password-email" class="form-label">이메일</label>
					            <input type="email" class="form-control" id="find-password-email" required>
					            <button type="button" class="btn btn-secondary mt-2" id="send-auth-code">인증번호 발송</button>
					        </div>
					        <div class="mb-3" id="auth-code-section" style="display:none;">
					            <label for="auth-code" class="form-label">인증번호</label>
					            <input type="text" class="form-control" id="auth-code" required>
					            <button type="button" class="btn btn-secondary mt-2" id="verify-auth-code">인증번호 확인</button>
					        </div>
					        <div class="d-grid gap-2" id="temp-password-section" style="display:none;">
					            <button type="button" class="btn btn-secondary" id="get-temp-password">다음</button>
					        </div>
					    </form>
					</div>
                </div>
                <div class="text-center mt-3">
                    <a href="/Guest/auth/Login">로그인 페이지로 돌아가기</a>
                </div>
            </div>
        </div>
        
        <%@ include file="/WEB-INF/views/Common/footer.jsp" %> <!-- 푸터 파일 포함 -->
    
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
