<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
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
            <input type="text" class="form-control" id="searchInput" placeholder="검색어를 입력하세요">
            <button type="submit" class="btn btn-primary">검색</button>
        </form>
    </div>

  

			<section class="row">
			    <!-- Example Popup Store Card -->
			   <div class="col-md-4 mb-4">
			        <div class="card">
			          	<a href="/PopupDetail3">
						    <img src="/image/Popup/game1.jpg" class="card-img-top" alt="카카오 캐릭터 굿즈">
						</a>
			            <div class="card-body">
			                <h5 class="card-title">배틀그라운드 팝업스토어 PUBG 성수</h5>
	                        <p class="card-text">서울특별시 성동구 왕십리로4길 5 한일피복공업(주)</p>
	                        <p class="card-text">24.08.01 - 24.08.18</p>
			            </div>
			       </div>
			    </div>
			   
			    
			    <!-- Repeat the structure for other cards -->
			    <!-- ... (Other popup store cards) -->
			    
			    <div class="col-md-4 mb-4">
			        <div class="card">
			        	<a href="/PopupDetail2">
						    <img src="/image/Popup/any1.jpg" class="card-img-top" alt="코난 캐릭터 굿즈">
						</a>
			            <div class="card-body">
			                <h5 class="card-title">스튜디오 지브리 타카하타 이사오전</h5>
	                        <p class="card-text">서울특별시 종로구 세종대로 175 세종문화회관</p>
	                        <p class="card-text">24.04.26 - 24.08.03</p>
			            </div>
			        </div>
			    </div>
			    
			    <div class="col-md-4 mb-4">
	                <div class="card">
						<a href="/PopupDetail">
						    <img src="/image/Popup/any2.jpg" class="card-img-top" alt="눈깔괴물 캐릭터 굿즈">
						</a>	                    
						<div class="card-body">
	                        <h5 class="card-title">롯데월드 X 명탐정 코난 팝업 MAGIC CITY</h5>
	                        <p class="card-text">서울특별시 송파구 올림픽로 240 롯데월드</p>
	                        <p class="card-text">24.07.01 - 24.09.01</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
						<a href="/PopupDetail4">
						    <img src="/image/Popup/sport1.jpg" class="card-img-top" alt="망곰이 캐릭터 굿즈">
						</a>	                    
						<div class="card-body">
	                        <h5 class="card-title">아디다스 FC BAYERN 팝업 스토어</h5>
	                        <p class="card-text">서울특별시 강남구 강남대로 470 808타워 아디다스</p>
	                        <p class="card-text">24.07.26 - 24.08.09</p>
	                    </div>
	                </div>
	            </div>
	            
	             <div class="col-md-4 mb-4">
	                <div class="card">
						<a href="/GoodsDetail5">
						    <img src="/image/Popup/game2.jpg" class="card-img-top" alt="니니즈 캐릭터 굿즈">
						</a>	                    
						<div class="card-body">
	                        <h5 class="card-title">모여봐요 동물의 숲 × 코엑스 아쿠아리움</h5>
	                        <p class="card-text">서울특별시 강남구 영동대로 513 코엑스 아쿠아리움</p>
	                        <p class="card-text">24.07.29 - 24.10.27</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
						<a href="/GoodsDetail6">
						    <img src="/image/Popup/etc3.jpg" class="card-img-top" alt="스누피 캐릭터 굿즈">
						</a>	                    
						<div class="card-body">
	                        <h5 class="card-title">아디다스 FC BAYERN 팝업 스토어</h5>
	                        <p class="card-text">서울특별시 강남구 강남대로 470 808타워 아디다스</p>
	                        <p class="card-text">24.07.26 - 24.08.09</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                    <img src="/image/Popup/etc4.jpg" class="card-img-top" alt="...">
	                    <div class="card-body">
	                       <h5 class="card-title">롯데월드 X 명탐정 코난 팝업 MAGIC CITY</h5>
	                        <p class="card-text">서울특별시 송파구 올림픽로 240 롯데월드</p>
	                        <p class="card-text">24.07.01 - 24.09.01</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/game1.jpg"class="card-img-top" alt="...">
	                        <div class="card-body">
	                            <h5 class="card-title">롯데월드 X 명탐정 코난 팝업 MAGIC CITY</h5>
	                        <p class="card-text">서울특별시 송파구 올림픽로 240 롯데월드</p>
	                        <p class="card-text">24.07.01 - 24.09.01</p>
	                        </div>
	                </div>
	            </div>
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/game1.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <h5 class="card-title">롯데월드 X 명탐정 코난 팝업 MAGIC CITY</h5>
	                        <p class="card-text">서울특별시 송파구 올림픽로 240 롯데월드</p>
	                        <p class="card-text">24.07.01 - 24.09.01</p>
	                        </div>
	                </div>
	            </div>
	            
	            
	              <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/game1.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <h5 class="card-title">롯데월드 X 명탐정 코난 팝업 MAGIC CITY</h5>
	                        <p class="card-text">서울특별시 송파구 올림픽로 240 롯데월드</p>
	                        <p class="card-text">24.07.01 - 24.09.01</p>
	                        </div>
	                </div>
	            </div>
	            
	           
	
	              <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/game1.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                           <h5 class="card-title">롯데월드 X 명탐정 코난 팝업 MAGIC CITY</h5>
	                        <p class="card-text">서울특별시 송파구 올림픽로 240 롯데월드</p>
	                        <p class="card-text">24.07.01 - 24.09.01</p>
	                        </div>
	                </div>
	            </div>
	            
	
	              <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Popup/game1.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <h5 class="card-title">롯데월드 X 명탐정 코난 팝업 MAGIC CITY</h5>
	                        <p class="card-text">서울특별시 송파구 올림픽로 240 롯데월드</p>
	                        <p class="card-text">24.07.01 - 24.09.01</p>
	                        </div>
	                </div>
	            </div>
            
            <button onclick="scrollToTop()" class="btn btn-dark fixed-bottom-right">
                TOP
            </button>
            <script>
                function scrollToTop() {
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                }
            </script>
        </section>

        <!-- 페이지네이션 -->
        <div class="pagination-container">
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <li class="page-item disabled">
                        <li class="page-item"><a class="page-link" href="#">&laquo;</a></li>
                        <li class="page-item"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">&raquo;</a></li>
                    <li class="page-item">
                    </li>
                </ul>
            </nav>
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

        const categorySelect = document.getElementById('categorySelect');
        const subCategorySelect = document.getElementById('subCategorySelect');

        categorySelect.addEventListener('change', () => {
            const selectedValue = categorySelect.value;
            subCategorySelect.disabled = !selectedValue;

            // Clear previous subcategories
            subCategorySelect.innerHTML = '<option value="" selected>서브 카테고리 선택</option>';

            if (selectedValue === 'location') {
                // Add location-specific subcategories
                subCategorySelect.innerHTML += '<option value="seoul">성수</option><option value="busan">마포</option><option value="incheon">영등포</option><option value="seoul">홍대</option><option value="busan">부산</option>';
            } else if (selectedValue === 'interest') {
                // Add interest-specific subcategories
                subCategorySelect.innerHTML += '<option value="gaming">음식</option><option value="art">애니</option><option value="sports">게임</option><option value="gaming">패션</option><option value="art">스포츠</option>';
            } else if (selectedValue === 'date') {
                // Add interest-specific subcategories
                subCategorySelect.innerHTML += '<option value="gaming">오늘</option><option value="art">7일</option><option value="sports">2주</option>';
            }
        });
    

        
        
    </script>
</body>
</html>
