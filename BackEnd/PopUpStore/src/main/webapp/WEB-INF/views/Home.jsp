<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<style>
		
		
		.chat-icon {
		    position: fixed; /* 화면에 고정 위치 */
		    bottom: 80px; /* 하단에서 80px 떨어진 위치 (TOP 버튼과의 거리 조정) */
		    right: 20px; /* 오른쪽에서 20px 떨어진 위치 */
		    padding: 10px;
		    background-color: #007bff; /* 아이콘 배경색 */
		    border-radius: 50%; /* 둥근 배경 */
		    color: white; /* 아이콘 색상 */
		    text-decoration: none;
		    font-size: 24px; /* 아이콘 크기 */
		    vertical-align: middle; /* 세로 정렬 */
		    z-index: 9999; /* TOP 버튼보다 위에 오도록 설정 */
		    transform: translate(-50%, 0); /* 가운데 정렬을 위한 위치 조정 */
		}
		
		.chat-icon:hover {
		    background-color: #0056b3; /* 호버 시 배경색 */
		}
		
		.chat-icon svg {
		    fill: currentColor; /* 아이콘 색상 설정 */
		}
</style>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Home</title>
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
		
	</head>	
	<body>
		<div class= "body1">
	    <div class="search-bar">
	        <form onsubmit="performSearch(); return false;">
	            <select class="form-select" id="categorySelect" aria-label="카테고리 선택" onchange="updateSubCategories()">
	                <option value="" selected>카테고리 선택</option>
	                <option value="date">날짜</option>
	                <option value="location">지역</option>
	                <option value="interest">관심</option>
	            </select>
	            <select class="form-select" id="subCategorySelect" aria-label="서브 카테고리 선택" disabled>
	                <option value="" selected>서브 카테고리 선택</option>
	            </select>
	            <input type="text" class="form-control" id="searchInput">
	            <button type="submit" class="btn btn-primary">검색</button>
	        </form>
	    </div>
	
	    
	        <section class="text-center my-6 section-popular">
            <h2 class="headline-font">8월 인기 팝업스토어</h2>

            <!-- Swiper Wrapper -->
            <div class="swiper-container-wrapper">
                <!-- Swiper -->
                <div class="swiper-container1">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide special-slide">	
                        	<a href="/PopupDetail2">
	                        	<img src="/image/Popup/any1.jpg" alt="스튜디오 지브리 타카하타 이사오전">
	                        </a>
	                        <div class="overlay-text-title">
	                        스튜디오 지브리 타카하타 이사오전 <br/><br/>
	                        </div>       
	                        <div class="overlay-text">
	                            24.04.26 - 24.08.03 <br>
	                            서울특별시 종로구 세종대로 175 세종문화회관 미술관 1, 2관
	                        </div>
	                    </div>
	                    <div class="swiper-slide special-slide">
						    <a href="/PopupDetail">
						        <img src="/image/Popup/any2.jpg" alt="롯데월드 X 명탐정 코난 팝업 MAGIC CITY">
						    </a>
						    <div class="overlay-text-title">
						        롯데월드 X 명탐정 코난 팝업 MAGIC CITY <br/><br/>
						    </div>       
						    <div class="overlay-text">
						        24.07.01 - 24.09.01 <br>
						        서울특별시 송파구 올림픽로 240 롯데월드
						    </div>
						</div>
	                    <div class="swiper-slide special-slide">
	                    	<a href="PopupDetail3">
	                        	<img src="/image/Popup/game1.jpg" alt="배틀그라운드 팝업스토어 PUBG 성수">
	                        </a>
	                        <div class="overlay-text-title">
	                            배틀그라운드 팝업스토어 PUBG 성수<br/><br/>
	                        </div>       
	                        <div class="overlay-text">
	                            24.08.01 - 24.08.18 <br>
	                            서울특별시 성동구 왕십리로4길 5 한일피복공업(주) 펍지 성수
	                        </div>
	                    </div>
	                    <div class="swiper-slide special-slide">
	                    	<a href="PopupDetail4">
	                        	<img src="/image/Popup/game2.jpg" alt="모여봐요 동물의 숲 × 코엑스 아쿠아리움">
	                        </a>
	                        <div class="overlay-text-title">
	                            모여봐요 동물의 숲 × 코엑스 아쿠아리움 <br/><br/>
	                        </div>       
	                        <div class="overlay-text">
	                            24.07.29 - 24.10.27 <br>
	                            서울특별시 강남구 영동대로 513 코엑스 아쿠아리움
	                        </div>
	                    </div>
	                    <div class="swiper-slide special-slide">
	                        <img src="/image/Popup/sport1.jpg">
	                        <div class="overlay-text-title">
	                            아디다스 FC BAYERN 팝업 스토어 <br/><br/>
	                        </div>       
	                        <div class="overlay-text">
	                            24.07.26 - 24.08.09 <br>
	                            서울특별시 강남구 강남대로 470 808타워 아디다스 강남브랜드센터
	                        </div>
	                    </div>
	                    <div class="swiper-slide special-slide">
	                        <img src="/image/Popup/any3.jpg">
	                        <div class="overlay-text-title">
	                            망그러진곰 비밀의 다락방 팝업스토어 <br/><br/>
	                        </div>       
	                        <div class="overlay-text">
	                            24.07.25 - 24.08.07 <br>
	                            서울특별시 영등포구 여의대로 108 파크원 더현대 서울 지하2층 아이코닉존
	                        </div>
	                    </div>
	                    <div class="swiper-slide special-slide">
	                        <img src="/image/Popup/any4.jpg">
	                        <div class="overlay-text-title">
	                            스누피가든 팝업스토어 <br/><br/>
	                        </div>       
	                        <div class="overlay-text">
	                            24.07.03 - 24.08.10 <br>
	                            제주특별자치도 제주시 공항로 2 제주국제공항 1층 GATE3
	                        </div>
	                    </div>
                        <!-- Add more slides as needed -->
                    </div>
                      <!-- Add Pagination -->
                    <div class="swiper-pagination"></div>
                    <!-- Add Navigation -->
                    <div class="swiper-button-next"></div>
                    <div class="swiper-button-prev"></div>
                </div>
            </div>
        </section>
	
	        <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <!-- Initialize Swiper -->
    <script>
        var swiper = new Swiper('.swiper-container1', {
            loop: true,
            slidesPerView: 2,
            spaceBetween: 0,
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
        });
    </script>
	        <br/>
		</div>
	
				
				
	        <section class="text-center my-5 section-current">
	        <br/><br/>
	           <h2 class="headline-font1">현재 진행중인 팝업스토어</h2>
	            <!-- <p>텍스트를 여기에 추가하고, 필요에 따라 스타일을 조정하세요.</p> -->
	        <div class="swiper-container-wrapper">
	            <!-- Swiper -->
	            <div class="swiper-container">
	                <div class="swiper-wrapper">
	                    <div class="swiper-slide">
	                        <img src="/image/Popup/etc2.jpg">
	                     
	                    </div>
	                    <div class="swiper-slide">
	                        <img src="/image/Popup/etc3.jpg">
	                        <div class="overlay-text-title2" style="color: #4e4f4e;"> 
	                           
	                        </div>       
	                        
	                    </div>
	                    <div class="swiper-slide">
	                        <img src="/image/Popup/etc4.jpg">
	                        
	                    </div>
	                    <div class="swiper-slide">
	                        <img src="/image/Popup/etc5.png">
	                        
	                    </div>
	                    <div class="swiper-slide">
	                        <img src="/image/Popup/etc6.jpg">
	                        
	                    </div>
	                    <div class="swiper-slide">
	                        <img src="/image/Popup/etc7.jpg">
	                        
	                    </div>
	                    <div class="swiper-slide">
	                        <img src="/image/Popup/etc8.jpg">
	                        
	
	                    <!-- 추가 이미지 슬라이드 -->
	                </div>
	                </div>
	                <!-- Add Pagination -->
	                <div class="swiper-pagination"></div>
	                <!-- Add Navigation -->
	                <div class="swiper-button-next"></div>
	                <div class="swiper-button-prev"></div>
	            </div>
	        </div>
	        <br/><br/><br/>
	
	        <!-- Swiper JS -->
	        <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	
	        <!-- Initialize Swiper -->
	        <script>
	            var swiper = new Swiper('.swiper-container', {
	                loop: true,
	                slidesPerView: 2,
	                spaceBetween: 0,
	                pagination: {
	                    el: '.swiper-pagination',
	                    clickable: true,
	                },
	                navigation: {
	                    nextEl: '.swiper-button-next',
	                    prevEl: '.swiper-button-prev',
	                },
	            });
	        </script>
			
			
			
			
	       
	        <h2 class="headline-font1">오픈 예정 팝업스토어</h2>

			<section class="row">
			    <!-- Example Popup Store Card -->
			   <div class="col-md-4 mb-4">
			        <div class="card">
			          <img src="/image/Popup/game1.jpg" class="card-img-top" alt="배틀그라운드 팝업스토어 PUBG 성수">
			            <div class="card-body">
			                <h5 class="card-title">배틀그라운드 팝업스토어 PUBG 성수</h5>
			                <p class="card-text">서울특별시 성동구 왕십리로4길 5 한일피복공업(주) 펍지 성수</p>
			                <p class="card-text">24.08.01 - 24.08.18</p>
			            </div>
			       </div>
			    </div>
			   
			    
			    <!-- Repeat the structure for other cards -->
			    <!-- ... (Other popup store cards) -->
			    
			    <div class="col-md-4 mb-4">
			        <div class="card">
			            <img src="/image/Popup/etc11.jpg" class="card-img-top" alt="쿠첸 팝업스토어 미토피아 페스티밥 in 고양">
			            <div class="card-body">
			                <h5 class="card-title">쿠첸 팝업스토어 미토피아 페스티밥 in 고양</h5>
			                <p class="card-text">경기도 고양시 덕양구 고양대로 1955 스타필드 고양 1층 센트럴 아트리움</p>
			                <p class="card-text">24.08.06 - 24.08.19</p>
			            </div>
			        </div>
			    </div>
			    
			    <div class="col-md-4 mb-4">
	                <div class="card">
	                    <img src="/image/Popup/any2.jpg"class="card-img-top" alt="...">
	                    <div class="card-body">
	                        <h5 class="card-title">롯데월드 X 명탐정 코난 팝업 MAGIC CITY</h5>
	                        <p class="card-text">서울특별시 송파구 올림픽로 240 롯데월드</p>
	                        <p class="card-text">24.07.01 - 24.09.01</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                    <img src="/image/Popup/sport1.jpg"class="card-img-top" alt="...">
	                    <div class="card-body">
	                        <h5 class="card-title">아디다스 FC BAYERN 팝업 스토어</h5>
	                        <p class="card-text">서울특별시 강남구 강남대로 470 808타워 아디다스 강남브랜드센터</p>
	                        <p class="card-text">24.07.26 - 24.08.09</p>
	                    </div>
	                </div>
	            </div>
	            
	             <div class="col-md-4 mb-4">
	                <div class="card">
	                    <img src="/image/Popup/game2.jpg"class="card-img-top" alt="...">
	                    <div class="card-body">
	                        <h5 class="card-title">모여봐요 동물의 숲 × 코엑스 아쿠아리움</h5>
	                        <p class="card-text">서울특별시 강남구 영동대로 513 코엑스 아쿠아리움</p>
	                        <p class="card-text">24.07.29 - 24.10.27</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                    <img src="/image/Popup/etc9.jpg"class="card-img-top"  alt="...">
	                    <div class="card-body">
	                        <h5 class="card-title">청소광 브라이언 팝업스토어</h5>
	                        <p class="card-text">서울특별시 용산구 한강대로23길 55 용산역 아이파크몰 리빙파크 3층 이벤트홀, A행사장</p>
	                        <p class="card-text">24.08.09 - 24.08.18</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                    <img src="/image/Popup/etc10.png" class="card-img-top" alt="...">
	                    <div class="card-body">
	                        <h5 class="card-title">한국타이어 X 양양 서피비치 팝업스토어</h5>
	                        <p class="card-text">강원특별자치도 양양군 현북면 하조대해안길 119 서피비치 3번 구역</p>
	                        <p class="card-text">24.08.09 - 24.08.18</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/etc11.jpg"class="card-img-top" alt="...">
	                        <div class="card-body">
	                            <h5 class="card-title">쿠첸 팝업스토어 미토피아 페스티밥 in 고양</h5>
	                            <p class="card-text">경기도 고양시 덕양구 고양대로 1955 스타필드 고양 1층 센트럴 아트리움</p>
	                            <p class="card-text">24.08.06 - 24.08.19</p>
	                        </div>
	                </div>
	            </div>
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/etc11.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <h5 class="card-title">쿠첸 팝업스토어 미토피아 페스티밥 in 고양</h5>
	                            <p class="card-text">경기도 고양시 덕양구 고양대로 1955 스타필드 고양 1층 센트럴 아트리움</p>
	                            <p class="card-text">24.08.06 - 24.08.19</p>
	                        </div>
	                </div>
	            </div>
	            
	            
	              <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/etc11.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <h5 class="card-title">쿠첸 팝업스토어 미토피아 페스티밥 in 고양</h5>
	                            <p class="card-text">경기도 고양시 덕양구 고양대로 1955 스타필드 고양 1층 센트럴 아트리움</p>
	                            <p class="card-text">24.08.06 - 24.08.19</p>
	                        </div>
	                </div>
	            </div>
	            
	           
	
	              <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/etc11.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <h5 class="card-title">쿠첸 팝업스토어 미토피아 페스티밥 in 고양</h5>
	                            <p class="card-text">경기도 고양시 덕양구 고양대로 1955 스타필드 고양 1층 센트럴 아트리움</p>
	                            <p class="card-text">24.08.06 - 24.08.19</p>
	                        </div>
	                </div>
	            </div>
	            
	
	              <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/etc11.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <h5 class="card-title">쿠첸 팝업스토어 미토피아 페스티밥 in 고양</h5>
	                            <p class="card-text">경기도 고양시 덕양구 고양대로 1955 스타필드 고양 1층 센트럴 아트리움</p>
	                            <p class="card-text">24.08.06 - 24.08.19</p>
	                        </div>
	                </div>
	            </div>
	
	    <div style="width: 80%; height: 80%; margin:  0px auto;">
	            <br/><br/><br/><br/><br/><br/>
			<h2 class="headline-font1">현재 판매중인 굿즈</h2>
	                <!-- <p>텍스트를 여기에 추가하고, 필요에 따라 스타일을 조정하세요.</p> -->
	            
	            <div class="swiper-container-wrapper2">
	                <!-- Swiper -->
	                <div class="swiper-container">
	                    <div class="swiper-wrapper">
	                        <div class="swiper-slide">
	                            <img src="/image/Goods/Goods1.jpg">
	                        </div>
	                        <div class="swiper-slide">
	                            <img src="image/Goods/Goods2.jpg">
	                        </div>
	                        <div class="swiper-slide">
	                            <img src="/image/Goods/Goods3.jpg">
	                        </div>
	                        <div class="swiper-slide">
	                            <img src="/image/Goods/Goods4.jpg">
	                        </div>
	                        <div class="swiper-slide">
	                            <img src="/image/Goods/Goods5.jpg">
	                        </div>
	                        <div class="swiper-slide">
	                            <img src="/image/Goods/Goods6.png">
	                        </div>
	                        <div class="swiper-slide">
	                            <img src="/image/Goods/Goods7.jpg">
	                        </div>
	                        <!-- 추가 이미지 슬라이드 -->
	                    </div>
	                    <!-- Add Pagination -->
	                    <div class="swiper-pagination"></div>
	                    <!-- Add Navigation -->
	                    <div class="swiper-button-next"></div>
	                    <div class="swiper-button-prev"></div>
	                </div>
	            </div>
	            <br/><br/><br/><br/><br/><br/>
	    </div>
	     <div>
        <div id="messages"></div>
		    <input type="text" id="userNick" placeholder="Your Nickname" />
		    <input type="text" id="content" placeholder="Message" />
		    <button onclick="sendMessage()">Send</button>
    </div>
    <div id="messages"></div>
	    </section>  
	            <!-- Swiper JS -->
	            <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	    
	            <!-- Initialize Swiper -->
	            <script>
	                var swiper = new Swiper('.swiper-container', {
	                    loop: true,
	                    slidesPerView: 4,
	                    spaceBetween: 0,
	                    pagination: {
	                        el: '.swiper-pagination',
	                        clickable: true,
	                    },
	                    navigation: {
	                        nextEl: '.swiper-button-next',
	                        prevEl: '.swiper-button-prev',
	                    },
	                });
	                
	            </script>

	    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	
		<button onclick="scrollToTop()" class="btn btn-dark fixed-bottom-right">
                TOP
            </button>
            <script>
                function scrollToTop() {
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                }
            </script>
	    <script>
	        // Swiper 초기화 스크립트
	        var swiper = new Swiper('.swiper-container1', {
	            loop: true,
	            slidesPerView: 2,
	            spaceBetween: 0,
	            pagination: {
	                el: '.swiper-pagination',
	                clickable: true,
	            },
	            navigation: {
	                nextEl: '.swiper-button-next',
	                prevEl: '.swiper-button-prev',
	            },
	        });
	
	        // 드롭다운 메뉴 스크립트
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
	    
	    <script>
	    function sendMessage() {
	        var content = document.getElementById('content').value;
	        var userNick = document.getElementById('userNick').value;

	        fetch('/chat/send', {
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify({
	                content: content,
	                userNick: userNick,
	                timestamp: new Date().toISOString()
	            })
	        }).then(function() {
	            document.getElementById('content').value = '';
	            loadMessages(); // 메시지를 전송한 후 다시 로드
	        }).catch(function(error) {
	            console.error('Error sending message:', error);
	        });
	    }

	    function loadMessages() {
	        fetch('/chat/messages')
	            .then(response => response.json())
	            .then(data => {
	                var messagesDiv = document.getElementById('messages');
	                messagesDiv.innerHTML = '';

	                console.log('Loaded messages:', data); // 디버깅용 로그

	                if (Array.isArray(data)) {
	                    data.forEach(function(message) {
	                        var messageElement = document.createElement('div');
	                        messageElement.innerText = `[${message.timestamp}] ${message.userNick}: ${message.content}`;
	                        messagesDiv.appendChild(messageElement);
	                    });
	                } else {
	                    console.error("Expected an array but received:", data);
	                    messagesDiv.innerText = 'Failed to load messages.';
	                }
	            }).catch(function(error) {
	                console.error('Error loading messages:', error);
	            });
	    }
	    
	    window.onload = function() {
	        const urlParams = new URLSearchParams(window.location.search);
	        if (urlParams.has('signupSuccess') && urlParams.get('signupSuccess') === 'true') {
	            alert('회원가입이 완료되었습니다! 가입해주셔서 감사합니다 ㅎ.ㅎ');
	        }
	    };
	    
	    
	    
    </script>
	  <!-- 채팅 아이콘 -->
   
		<a href="/chatLogin" class="chat-icon" title="채팅하기">
		    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-wechat" viewBox="0 0 16 16">
		        <path d="M11.176 14.429c-2.665 0-4.826-1.8-4.826-4.018 0-2.22 2.159-4.02 4.824-4.02S16 8.191 16 10.411c0 1.21-.65 2.301-1.666 3.036a.32.32 0 0 0-.12.366l.218.81a.6.6 0 0 1 .029.117.166.166 0 0 1-.162.162.2.2 0 0 1-.092-.03l-1.057-.61a.5.5 0 0 0-.256-.074.5.5 0 0 0-.142.021 5.7 5.7 0 0 1-1.576.22M9.064 9.542a.647.647 0 1 0 .557-1 .645.645 0 0 0-.646.647.6.6 0 0 0 .09.353Zm3.232.001a.646.646 0 1 0 .546-1 .645.645 0 0 0-.644.644.63.63 0 0 0 .098.356"/>
		        <path d="M0 6.826c0 1.455.781 2.765 2.001 3.656a.385.385 0 0 1 .143.439l-.161.6-.1.373a.5.5 0 0 0-.032.14.19.19 0 0 0 .193.193q.06 0 .111-.029l1.268-.733a.6.6 0 0 1 .308-.088q.088 0 .171.025a6.8 6.8 0 0 0 1.625.26 4.5 4.5 0 0 1-.177-1.251c0-2.936 2.785-5.02 5.824-5.02l.15.002C10.587 3.429 8.392 2 5.796 2 2.596 2 0 4.16 0 6.826m4.632-1.555a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0m3.875 0a.77.77 0 1 1-1.54 0 .77.77 0 0 1 1.54 0"/>
		    </svg>
		</a>
	<%@ include file="/WEB-INF/views/Common/footer.jsp" %> 
	</body>
</html>
