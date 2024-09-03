<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <!-- Kakao 지도 API 스크립트 추가 -->
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_APP_KEY&libraries=services"></script>
<title>Insert title here</title>
<style>
		#map {
            width: 80%;
            height: 50%; /* 원하는 높이로 설정 */
            overflow: hidden;
            position: relative;
            margin: 0 auto; /* 가운데 정렬 */
        }
        .facilities-icons {
            display: flex; /* Flexbox 활성화 */
            flex-direction: column; /* 세로 방향으로 설정 */
            align-items: center; /* 수평 중앙 정렬 */
            font-size: 25px; /* 아이콘 크기 */
            color: #fff; /* 아이콘 색상 */
            margin: 20px; /* 카드 내부 여백 */
        }
        .facilities-icons1 {
            font-size: 25px; /* 아이콘 크기 */
            color: #fff; /* 아이콘 색상 */
            margin: 20px; /* 카드 내부 여백 */
            display: flex; /* Flexbox 활성화 */
            flex-wrap: wrap; /* 줄 바꿈 활성화 */
            flex-direction: row; /* 가로 방향으로 정렬 */
            justify-content: center; /* 수평 중앙 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
        }
        .facility-item i {
            font-size: 25px; /* 아이콘 크기 */
            text-align: center;
        }
        .facility-item {
            display: flex;
            align-items: center; /* 아이템들 수직 중앙 정렬 */
            margin: 8px; /* 아이콘과 텍스트 사이에 간격 추가 */
            font-size: 10px;
        }
        .facilities-icons i {
            margin-left: 9px; /* 아이콘 간격 */
            margin-right: 5px;
           
        }
        .facilities-icons h5 {
            text-align: center; /* 제목 중앙 정렬 */
            margin-bottom: 15px; /* 제목과 아이콘 간의 여백 추가 */
        }
        .facilities-icons1 h5 {
            text-align: center; /* 제목 중앙 정렬 */
            margin-bottom: 15px; /* 제목과 아이콘 간의 여백 추가 */
        }
        .facilities-icons h6 {
            display: inline; /* 텍스트를 아이콘 옆에 표시 */
            margin-left: 5px; /* 텍스트와 아이콘 사이 여백 */
        }

</style>
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
    
    <main class="container my-4">
        <!-- Swiper Wrapper -->
        <div class="swiper-container-wrapper">
            <!-- Swiper -->
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <img src="image/popup/Ghibli1.png">
                        <div class="overlay-text-title">
                        </div>       
                    </div>
                    
                    <div class="swiper-slide">
                        <img src="image/popup/Ghibli2.png">
                        <div class="overlay-text-title">
                            
                        </div>       
                    </div>
                    <div class="swiper-slide">
                        <img src="image/popup/Ghibli3.png">
                        <div class="overlay-text-title">
                        </div>       
                    </div>
                    <div class="swiper-slide">
                        <img src="image/popup/Ghibli4.png">
                        <div class="overlay-text-title">
                        </div>       
                    </div>
                    <div class="swiper-slide">
                        <img src="image/popup/Ghibli5.png">
                        <div class="overlay-text-title">
                        </div>       
                    </div>
                    <div class="swiper-slide">
                        <img src="image/popup/Ghibli6.png">
                        <div class="overlay-text-title">
                        </div>       
                    </div>
                    <!-- 추가 이미지 슬라이드 -->
                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
                <!-- Add Navigation -->
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
            </div>
            <div class="card bg-dark text-white"style="width: 100%;">
                <br/>
                <h5 class="card-title">&nbsp;&nbsp;&nbsp;스튜디오 지브리-타카하타이사오전</h5>
                <p class="card-text">&nbsp;&nbsp;&nbsp;24.04.26 - 24.08.03</p>
                <p class="card-text">&nbsp;&nbsp;&nbsp;서울특별시 종로구 세종대로 175 세종문화회관 미술관 1, 2관</p>
                <p>&nbsp;&nbsp;&nbsp; #애니 &nbsp; #음악 &nbsp; #힐링 &nbsp; #전연령</p>
                <div class="d-flex justify-content-between align-items-center ms-auto me-10 ">
                    <span class="d-flex align-items-center me-30">
                        <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-eye me-2" viewBox="0 0 16 16">
                            <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM8 4.5a3.5 3.5 0 1 1 0 7 3.5 3.5 0 0 1 0-7z"/>
                            <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5z"/>
                        </svg>
                    </span>
                    </button> 

                    <button class="btn btn-outline-light d-flex align-items-center ms-auto me-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
                            <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1"/>
                        </svg>
                    </button>
                    

                    <button class="btn btn-outline-light d-flex align-items-center me-2">
                        <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-share-fill" viewBox="0 0 16 16">
                            <path d="M11 2.5a2.5 2.5 0 1 1 .603 1.628l-6.718 3.12a2.5 2.5 0 0 1 0 1.504l6.718 3.12a2.5 2.5 0 1 1-.488.876l-6.718-3.12a2.5 2.5 0 1 1 0-3.256l6.718-3.12A2.5 2.5 0 0 1 11 2.5"/>
                        </svg>
                    </button>  
                </div>
            </div>
        <br/>
        </div>


        <div class="card bg-dark text-white" style="width: 80%;  margin:  0px auto;">
            <section class="text-center my-5">
                <h5 style="color: #fff;">현재 판매중인 굿즈!</h5>
                <!-- <p>텍스트를 여기에 추가하고, 필요에 따라 스타일을 조정하세요.</p> -->
            </section>
            <div class="swiper-container-wrapper2">
                <!-- Swiper -->
                <div class="swiper-container">
                    <div class="swiper-wrapper">
                        <div class="swiper-slide">
                            <img src="image/Goods/Goods1.jpg">
                        </div>
                        <div class="swiper-slide">
                            <img src="image/Goods/Goods2.jpg">
                        </div>
                        <div class="swiper-slide">
                            <img src="image/Goods/Goods3.jpg">
                        </div>
                        <div class="swiper-slide">
                            <img src="image/Goods/Goods4.jpg">
                        </div>
                        <div class="swiper-slide">
                            <img src="image/Goods/Goods5.jpg">
                        </div>
                        <div class="swiper-slide">
                            <img src="image/Goods/Goods6.png">
                        </div>
                        <div class="swiper-slide">
                            <img src="image/Goods/Goods7.jpg">
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
    <br/>








        <div class="card bg-dark text-white" style="width: 80%; margin: 0 auto;">
            <h5 style="text-align: center;"><br/>&nbsp;&nbsp;&nbsp;편의시설</h5>
            <div class="facilities-icons1">
                
                <div class="facility-item">
                    <i class="fas fa-wifi" title="WiFi"></i>
                    &nbsp;&nbsp;<h6 style="font-size: 15px;">Wifi</h6>
                </div>
                <div class="facility-item">
                    <i class="fas fa-utensils" title="식사"></i>
                    &nbsp;&nbsp;<h6 style="font-size: 15px;">식사</h6>
                </div>
                <div class="facility-item">
                    <i class="fas fa-parking" title="주차"></i>
                    &nbsp;&nbsp;<h6 style="font-size: 15px;">주차</h6>
                </div>
                <div class="facility-item">
                    <i class="fas fa-restroom" title="화장실"></i>
                    &nbsp;&nbsp;<h6 style="font-size: 15px;">화장실</h6>
                </div>
                <div class="facility-item">
                    <i class="fas fa-baby-carriage" title="유아휴게실"></i>
                    &nbsp;&nbsp;<h6 style="font-size: 15px;">유아휴게실</h6>
                </div>
                <div class="facility-item">
                    <i class="fas fa-bell" title="안내센터"></i>
                    &nbsp;&nbsp;<h6 style="font-size: 15px;">안내센터</h6>
                </div>
            </div>
        </div>
        
        <br/>
        <div class="card bg-dark text-white" style="width: 80%; margin: 0 auto;">
            <div class="facilities-icons">
                <h5>&nbsp;&nbsp;&nbsp;이용 시간</h5>
               
                <h6>월 : 10:00 ~ 20:00</h6><br/>
                <h6>화 : 10:00 ~ 20:00</h6><br/> 
                <h6>수 : 10:00 ~ 20:00</h6><br/>
                <h6>목 : 10:00 ~ 20:00</h6><br/>
                <h6>금 : 10:00 ~ 20:00</h6><br/>
                <h6>토 : 10:00 ~ 20:00</h6><br/>
                <h6>일 : 10:00 ~ 20:00</h6><br/>
                <h6>&nbsp;(입장마감 : 19:00)</h6>
            </div>
        </div>
        <br/>
        <div class="card bg-dark text-white" style="width: 80%; margin: 0 auto;">
            <div class="facilities-icons">
                <h5>&nbsp;&nbsp;&nbsp;팝업스토어소개</h5>
               
                <div class="popup-info" style="align-items: center;">
                      본 전시에서는 오늘날 일본 애니메이션을 있게 한 타카하타의 '연출'이라는
                    포인트에 주목하여 빨강머리 앤, 알프스소녀 하이디, 반딧불이의 묘, 폼포코 너구리 대작전,
                    폼포코 너구리 대작전, 가구야 공주 이야기 등 다양한 작품의 미공개 자료를 소개하며
                    그의 다면적 작품 세계의 비밀을 파헤칩니다. <br>
                    <br>
                    	간단히 알아차리기 힘들 만큼 넓게 침투해 있는 그의 형향력. <br>
                    이번 전시에서는 애니메이션에 대한 타카하타의 공헌을 확인하실 수 있습니다.                	
                </div>
               
            </div>
        </div>

        
        
        


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
        <button onclick="scrollToTop()" class="btn btn-dark fixed-bottom-right">
            TOP
        </button>
        <script>
            function scrollToTop() {
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }
        </script>

        

    </main>
    <div id="map" style="width:60%; height:700px"></div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2c1897221bd5b11b57d2fb630a1eb08d&libraries=services"></script>
    <script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
        mapOption = {
            center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
            level: 3 // 지도의 확대 레벨
        };  

    // 지도를 생성합니다    
    var map = new kakao.maps.Map(mapContainer, mapOption); 

    // 주소-좌표 변환 객체를 생성합니다
    var geocoder = new kakao.maps.services.Geocoder();

    // 주소로 좌표를 검색합니다
    geocoder.addressSearch('서울특별시 종로구 세종대로 175 세종문화회관 미술관 1, 2관', function(result, status) {

        // 정상적으로 검색이 완료됐으면 
        if (status === kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            // 결과값으로 받은 위치를 마커로 표시합니다
            var marker = new kakao.maps.Marker({
                map: map,
                position: coords
            });

            // 인포윈도우로 장소에 대한 설명을 표시합니다

            // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
            map.setCenter(coords);
        } 
    });    
</script>
<br/>

<div class="card bg-dark text-white" style="width: 70%; margin: 0 auto;">
    <div class="facilities-icons">
        <h5>&nbsp;&nbsp;&nbsp;관련 팝업스토어</h5>
        <main class="container my-4">
            <section class="row">
                <!-- 이미지 카드 1 -->
                <div class="col-md-4 mb-4">
                    <div class="card bg-dark text-white">
                        <img src="/image/game1.jpg" class="card-img-top" alt="Game 1">
                        <div class="card-body">
                            <h5 class="card-title" >배틀그라운드 팝업스토어 PUBG 성수</h5>
                            <p class="card-text" style="font-size: 15px;">서울특별시 성동구 왕십리로4길 피복공업</p>
                            <p class="card-text"  style="font-size: 15px;">24.08.01 - 24.08.18</p>
                            <div class="d-flex justify-content-between align-items-center mt-3 w-100">
                                <span class="d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-eye me-2" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM8 4.5a3.5 3.5 0 1 1 0 7 3.5 3.5 0 0 1 0-7z"/>
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5z"/>
                                    </svg>
                                </span>
                                <button class="btn btn-outline-light d-flex align-items-center ms-auto me-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
                                        <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1"/>
                                    </svg>
                                </button>
                                <button class="btn btn-outline-light d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-share-fill" viewBox="0 0 16 16">
                                        <path d="M11 2.5a2.5 2.5 0 1 1 .603 1.628l-6.718 3.12a2.5 2.5 0 0 1 0 1.504l6.718 3.12a2.5 2.5 0 1 1-.488.876l-6.718-3.12a2.5 2.5 0 1 1 0-3.256l6.718-3.12A2.5 2.5 0 0 1 11 2.5"/>
                                    </svg>
                                </button>  
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 이미지 카드 2 -->
                <div class="col-md-4 mb-4">
                    <div class="card bg-dark text-white">
                        <img src="/image/any1.jpg" class="card-img-top" alt="Any 1">
                        <div class="card-body">
                            <h5 class="card-title" >스튜디오 지브리 타카하타 이사오전</h5>
                            <p class="card-text" style="font-size: 15px;">서울특별시 종로구 세종대로 175 문화회관</p>
                            <p class="card-text" style="font-size: 15px;">24.04.26 - 24.08.03</p>
                            <div class="d-flex justify-content-between align-items-center mt-3 w-100">
                                <span class="d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-eye me-2" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM8 4.5a3.5 3.5 0 1 1 0 7 3.5 3.5 0 0 1 0-7z"/>
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5z"/>
                                    </svg>
                                </span>
                                <button class="btn btn-outline-light d-flex align-items-center ms-auto me-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
                                        <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1"/>
                                    </svg>
                                </button>
                                <button class="btn btn-outline-light d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-share-fill" viewBox="0 0 16 16">
                                        <path d="M11 2.5a2.5 2.5 0 1 1 .603 1.628l-6.718 3.12a2.5 2.5 0 0 1 0 1.504l6.718 3.12a2.5 2.5 0 1 1-.488.876l-6.718-3.12a2.5 2.5 0 1 1 0-3.256l6.718-3.12A2.5 2.5 0 0 1 11 2.5"/>
                                    </svg>
                                </button>  
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 이미지 카드 3 -->
                <div class="col-md-4 mb-4">
                    <div class="card bg-dark text-white">
                        <img src="/image/any2.jpg" class="card-img-top" alt="Any 2">
                        <div class="card-body">
                            
                            <h5 class="card-title">롯데월드 X 명탐정 코난 팝업 MAGIC CITY</h5>
                            <p class="card-text" style="font-size: 15px;">서울특별시 송파구 올림픽로 240 롯데월드</p>
                            <p class="card-text" style="font-size: 15px;">24.07.01 - 24.09.01</p>
                            <div class="d-flex justify-content-between align-items-center mt-3 w-100">
                                <span class="d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-eye me-2" viewBox="0 0 16 16">
                                        <path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM8 4.5a3.5 3.5 0 1 1 0 7 3.5 3.5 0 0 1 0-7z"/>
                                        <path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5z"/>
                                    </svg>
                                </span>
                                <button class="btn btn-outline-light d-flex align-items-center ms-auto me-2">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-suit-heart-fill" viewBox="0 0 16 16">
                                        <path d="M4 1c2.21 0 4 1.755 4 3.92C8 2.755 9.79 1 12 1s4 1.755 4 3.92c0 3.263-3.234 4.414-7.608 9.608a.513.513 0 0 1-.784 0C3.234 9.334 0 8.183 0 4.92 0 2.755 1.79 1 4 1"/>
                                    </svg>
                                </button>
                                <button class="btn btn-outline-light d-flex align-items-center">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-share-fill" viewBox="0 0 16 16">
                                        <path d="M11 2.5a2.5 2.5 0 1 1 .603 1.628l-6.718 3.12a2.5 2.5 0 0 1 0 1.504l6.718 3.12a2.5 2.5 0 1 1-.488.876l-6.718-3.12a2.5 2.5 0 1 1 0-3.256l6.718-3.12A2.5 2.5 0 0 1 11 2.5"/>
                                    </svg>
                                </button>  
                            </div>
                        </div>
                    </div>
                </div>
    		</div>
		</div>
	<br/>
	<%@ include file="/WEB-INF/views/Common/footer.jsp" %> 
</body>
</html>