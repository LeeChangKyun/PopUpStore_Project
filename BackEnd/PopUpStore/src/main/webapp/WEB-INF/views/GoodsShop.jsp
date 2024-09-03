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
			          	<a href="/GoodsDetail">
						    <img src="/image/Goods/Goods8.jpg" class="card-img-top" alt="카카오 캐릭터 굿즈">
						</a>
			            <div class="card-body">
			                <p class="card-text"> 상품명 : 카카오 캐릭터 굿즈</p>
			                <p class="card-text"> 가격: 22,999원</p>
			            </div>
			       </div>
			    </div>
			   
			    
			    <!-- Repeat the structure for other cards -->
			    <!-- ... (Other popup store cards) -->
			    
			    <div class="col-md-4 mb-4">
			        <div class="card">
			        	<a href="/GoodsDetail2">
						    <img src="/image/Goods/Goods3.jpg" class="card-img-top" alt="코난 캐릭터 굿즈">
						</a>
			            <div class="card-body">
			                <p class="card-text"> 상품명 : 코난 캐릭터 굿즈</p>
			                <p class="card-text"> 가격: 29,800원</p>
			            </div>
			        </div>
			    </div>
			    
			    <div class="col-md-4 mb-4">
	                <div class="card">
						<a href="/GoodsDetail3">
						    <img src="/image/Goods/Goods5.jpg" class="card-img-top" alt="눈깔괴물 캐릭터 굿즈">
						</a>	                    
						<div class="card-body">
	                        <p class="card-text"> 상품명 : 눈깔괴물 캐릭터 굿즈</p>
	                        <p class="card-text"> 가격: 9,999원</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
						<a href="/GoodsDetail4">
						    <img src="/image/Goods/Goods4.jpg" class="card-img-top" alt="망곰이 캐릭터 굿즈">
						</a>	                    
						<div class="card-body">
	                        <p class="card-text"> 상품명 : 망곰이 캐릭터 굿즈</p>
	                        <p class="card-text"> 가격: 13,000원</p>
	                    </div>
	                </div>
	            </div>
	            
	             <div class="col-md-4 mb-4">
	                <div class="card">
						<a href="/GoodsDetail5">
						    <img src="/image/Goods/Goods9.jpg" class="card-img-top" alt="니니즈 캐릭터 굿즈">
						</a>	                    
						<div class="card-body">
	                        <p class="card-text"> 상품명 : 니니즈 캐릭터 굿즈</p>
	                        <p class="card-text"> 가격: 20,000원</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
						<a href="/GoodsDetail6">
						    <img src="/image/Goods/Goods1.jpg" class="card-img-top" alt="스누피 캐릭터 굿즈">
						</a>	                    
						<div class="card-body">
	                        <p class="card-text"> 상품명 : 스누피 캐릭터 굿즈</p>
	                        <p class="card-text"> 가격: 19,000원</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                    <img src="/image/Goods/Goods7.jpg" class="card-img-top" alt="...">
	                    <div class="card-body">
	                        <p class="card-text"> 상품명 : 스누피 굿즈</p>
	                        <p class="card-text"> 가격: 20,000원</p>
	                    </div>
	                </div>
	            </div>
	            
	            
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Goods/goods8.jpg"class="card-img-top" alt="...">
	                        <div class="card-body">
	                            <p class="card-text"> 상품명 : 카카오 굿즈</p>
	                            <p class="card-text"> 가격: 23,000원</p>
	                        </div>
	                </div>
	            </div>
	            
	            <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Goods/goods9.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <p class="card-text"> 상품명 : 카카오 굿즈</p>
	                            <p class="card-text"> 가격: 21,000원</p>
	                        </div>
	                </div>
	            </div>
	            
	            
	              <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Goods/Goods7.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <p class="card-text">상품명 : 스누피 굿즈</p>
	                            <p class="card-text">가격: 23,000원</p>
	                        </div>
	                </div>
	            </div>
	            
	           
	
	              <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Goods/goods9.jpg"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <p class="card-text"> 상품명 : 카카오 굿즈</p>
	                            <p class="card-text"> 가격: 21,000원</p>
	                        </div>
	                </div>
	            </div>
	            
	
	              <div class="col-md-4 mb-4">
	                <div class="card">
	                        <img src="/image/Goods/Goods6.png"class="card-img-top"  alt="...">
	                        <div class="card-body">
	                            <p class="card-text"> 상품명 : 짱구 굿즈</p>
	                            <p class="card-text"> 가격: 19,000원</p>
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
