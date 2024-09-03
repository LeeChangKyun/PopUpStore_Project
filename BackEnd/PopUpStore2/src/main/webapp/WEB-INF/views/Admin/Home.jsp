<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/adminheader.jsp" %>
<!DOCTYPE html>
<html lang="ko">
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
	                    <div class="swiper-slide">	
	                        <a href="../PopupDetail2">
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
	                    <div class="swiper-slide">
	                        <a href="../PopupDetail">
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
	                    <div class="swiper-slide">
							<a href="../PopupDetail3">
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
	                    <div class="swiper-slide">
							<a href="../PopupDetail4">
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

		<%@ include file="/WEB-INF/views/Common/footer.jsp" %>

	    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	
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
	        
	     	// 관리자로 로그인했을 떄 스크립트
			document.addEventListener("DOMContentLoaded", function() {
		        const urlParams = new URLSearchParams(window.location.search);
		        const adminLogin = urlParams.get('adminLogin');
		
		        // 새로고침 여부를 확인하기 위한 더 호환성 있는 방법
		        const navigationEntries = performance.getEntriesByType('navigation');
		        const isReload = navigationEntries.length > 0 && navigationEntries[0].type === 'reload';
		
		        // 새로고침에 의한 페이지 로드가 아닌 경우에만 알림 표시
		        if (adminLogin === 'true' && !isReload) {
		            alert("관리자로 로그인 하셨습니다!");
		        }
		    });
		
		    if (window.history && window.history.pushState) {
		        window.history.pushState('forward', null, window.location.href);
		
		        window.onpopstate = function() {
		            window.history.pushState('forward', null, window.location.href);
		            window.location.href = '/Admin/Home?adminLogin=true';
		        };
		    }
	        
	    </script>
	
	<c:if test="${not empty successMessage}">
    <script>
        // successMessage가 비어 있지 않은지 확인하고 alert을 실행
        if ("${successMessage}".trim() !== "") {
            alert("${successMessage}");
        }
    </script>
</c:if>
	</body>
</html>
