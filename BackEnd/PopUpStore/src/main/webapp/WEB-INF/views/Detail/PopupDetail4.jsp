<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
<!DOCTYPE html>
<html>
	<style>
	 #map {
            width: 80%;
            height: 500px; /* 원하는 높이로 설정 */
            overflow: hidden;
            position: relative;
            margin: 0 auto; /* 가운데 정렬 */
        }
        
	.info-window {
	    padding: 1px; /* 패딩 줄이기 */
	    font-size: 12px; /* 폰트 크기 줄이기 */
	    color: #333;
	    background-color: #fff;
	    border-radius: 5px;
	    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
	    max-width: 150px; /* 최대 너비 조정 */
	    text-align: center; /* 텍스트 및 이미지 중앙 정렬 */
	}
	
	.info-window h4 {
	    display: none; /* 제목 숨기기 */
	}
	
	.info-window p {
	    display: none; /* 내용 숨기기 */
	}
	
	.info-window img {
	    width: 100%; /* 이미지가 인포 윈도우 너비에 맞도록 설정 */
	    height: auto;
	    border-radius: 3px;
	    margin-top: 2px; /* 상단 여백 줄이기 */
	}
	
	#popup-container {
	    display: none; /* 페이지 로드 시 팝업 컨테이너를 숨김 */
	    /* 나머지 스타일은 그대로 유지 */
	    align-items: flex-start; /* 상단 정렬 */
	    position: absolute;
	    background-color: #fff;
	    border: 1px solid #ccc;
	    padding: 10px;
	    z-index: 2000;
	    border-radius: 5px;
	    box-shadow: 0 2px 4px rgba(0,0,0,0.2);
	    bottom: 10px; /* 하단에서 10px 떨어진 위치 */
	    left: 50%; /* 수평 가운데 정렬 */
	    transform: translateX(-50%); /* 수평 가운데 정렬을 위한 변환 */
	    width: 500px; /* 원하는 가로 사이즈로 조정 */
	}
	#popup-content {
	    padding: 10px;
	    margin: 0 auto;
	    width: 450px;
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}
	
	#popup-content img {
	    width: 100px; /* 이미지 너비 조정 */
	    height: auto; /* 비율 유지 */
	    max-width: 100%; /* 컨테이너 너비를 넘어가지 않도록 설정 */
	    border-radius: 3px; /* 이미지에 둥근 모서리 추가 */
	    margin-right: 15px; /* 이미지와 콘텐츠 사이의 여백 추가 */
	}
	#popup-content h3{
	    font-size: 20px;
	    font-weight: 700;
	    color: #222;
	}
	#popup-content p{
		font-size: 14px;
		color: #333;
	}
	#popup-content h4{
	    font-size: 12px;
	    color: #666;
	}
	#popup-content h5{
	    font-size: 12px;
	    color: #999;
	}
		/* 모든 텍스트 색상을 흰색으로 설정 */
        .card-text {
            color: white;
        }

			cardc {
		    padding: 10px; /* 카드 내부 여백 */
		    box-shadow: 0 2px 4px rgba(0.1, 0.1, 0.1, 0.1); /* 그림자 조정 */
		}
        /* 이 스타일은 #애니, #음식, #게임, #스포츠 부분의 색상도 흰색으로 설정합니다. */
        p {
            color: white;
        }

		.facilities-icons {
            /* 편의시설 아이콘을 세로로 정렬하고, 크기와 색상 설정 */
            display: flex; /* Flexbox 활성화 */
            flex-direction: column; /* 세로 방향으로 설정 */
            align-items: center; /* 수평 중앙 정렬 */
            font-size: 25px; /* 아이콘 크기 */
            color: #4e4f4e; /* 아이콘 색상 */
            margin: 20px; /* 카드 내부 여백 */
        }

        .facilities-icons1 {
            /* 편의시설 아이콘을 가로로 정렬하고, 크기와 색상 설정 */
            font-size: 25px; /* 아이콘 크기 */
            color: #4e4f4e; /* 아이콘 색상 */
            margin: 20px; /* 카드 내부 여백 */
            display: flex; /* Flexbox 활성화 */
            flex-wrap: wrap; /* 줄 바꿈 활성화 */
            flex-direction: row; /* 가로 방향으로 정렬 */
            justify-content: center; /* 수평 중앙 정렬 */
            align-items: center; /* 수직 중앙 정렬 */
        }

        .facility-item i {
            /* 개별 편의시설 아이콘의 크기를 설정하고 중앙 정렬 */
            font-size: 25px;
            text-align: center;
        }

        .facility-item {
            /* 편의시설 항목을 수직으로 중앙 정렬하고, 여백 설정 */
            display: flex;
            align-items: center; /* 아이템들 수직 중앙 정렬 */
            margin: 8px; /* 아이콘과 텍스트 사이에 간격 추가 */
            font-size: 10px;
        }

        .facilities-icons i {
            /* 아이콘 간의 간격을 설정 */
            margin-left: 9px;
            margin-right: 5px;
        }

        .facilities-icons h5 {
            /* 제목을 중앙 정렬하고, 아래 여백 설정 */
            text-align: center;
            margin-bottom: 15px;
        }

        .facilities-icons1 h5 {
            /* 제목을 중앙 정렬하고, 아래 여백 설정 */
            text-align: center;
            margin-bottom: 15px;
        }

        .facilities-icons h6 {
            /* 텍스트를 아이콘 옆에 표시하고, 간격 설정 */
            display: inline;
            margin-left: 5px;
        }
</style>
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


            <!-- Swiper Wrapper -->
            <div class="swiper-container-wrapper">
                <!-- Swiper -->
                <div class="swiper-container1">
                    <div class="swiper-wrapper">
	                    <div class="swiper-slide special-slide">
						        <img src="image/popup/mo1.png"> 
						</div>
	                    <div class="swiper-slide special-slide">
	                        	<img src="image/popup/mo2.png">  
	                    </div>
	                    <div class="swiper-slide special-slide">
	                    	<a href="PopupDetail4">
	                        	<img src="image/popup/mo3.png">
	                        </a>     
	                    </div>
	                    <div class="swiper-slide special-slide">
	                        <img src="image/popup/mo4.png">
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
            <br/>
            <h5 class="card-title" style="color: white; font-size: 24px;">&nbsp;&nbsp;&nbsp;모여봐요 동물의 숲 × 코엑스 아쿠아리움</h5>
		    <br/>
		    <p class="card-text" style="font-size: 20px;">&nbsp;&nbsp;&nbsp;24.04.26 - 24.08.03</p>
		    <p class="card-text" style="font-size: 20px;">&nbsp;&nbsp;&nbsp;서울특별시 성동구 왕십리로4길 5 한일피복공업(주) 펍지 성수</p>
		    <p style="font-size: 20px;">&nbsp;&nbsp;&nbsp; #게임 &nbsp; #체험 &nbsp; #힐링 &nbsp; #전연령</p>
                <div class="d-flex justify-content-between align-items-center ms-auto me-10 ">
                    <span class="d-flex align-items-center me-30">
                        <svg xmlns="http://www.w3.org/2000/svg" width="13" height="13" fill="currentColor" class="bi bi-eye me-2" viewBox="0 0 16 16">
                        </svg>
                    </span>
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
			
			
			
			
	       <div class="cardc">
	        <h2 class="headline-font1">편의시설</h2>

			<section class="row">
			    <!-- Example Popup Store Card -->
			   <div class="col-md-4 mb-4">
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

	    <div style="width: 80%; height: 80%; margin:  0px auto;">
	            <br/>
			<h2 class="headline-font1">이용 시간</h2>
	           <div class="facilities-icons">
                <h6>월 : 10:30 ~ 21:00</h6><br/>
                <h6>화 : 10:30 ~ 21:00</h6><br/> 
                <h6>수 : 10:30 ~ 21:00</h6><br/>
                <h6>목 : 10:30 ~ 21:00</h6><br/>
                <h6>금 : 10:30 ~ 21:00</h6><br/>
                <h6>토 : 10:30 ~ 21:00</h6><br/>
                <h6>일 : 10:30 ~ 21:00</h6>
            </div>
	    </div>
	    
	    <div style="width: 80%; height: 80%; margin:  0px auto;">
	    <br/><br/>
			<h2 class="headline-font1">팝업스토어소개</h2>
			<br/>
	         <div class="popup-info" style="align-items: center;">
                     😎작년에 이어 다시 돌아온 BIAF X 명탐정 코난 팝업스토어<br>
                    하지만 올해는 거기에 '명탐정 코난: 100만 달러의 펜타그램'을 곁들였다💪<br>
                    7월 17일 개봉하는 '명탐정 코난: 100만 달러의 펜타그램' 직관하고, 8월 1일 현대백화점 중동점 U-플렉스 1층에서 만나요🔥
                </div>
	    </div>
	    </div>
	    <br/><br/>
	   <div id="map" style="position:relative;">
            <div id="popup-container">
                <div id="popup-content"></div>
            </div>
        </div>
        <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5a4f12f046988db3dab2b83e5335845d&libraries=services"></script>
        <script>
            var mapContainer = document.getElementById('map'),
                mapOption = {
                    center: new kakao.maps.LatLng(33.450701, 126.570667),
                    level: 8
                };

            var map = new kakao.maps.Map(mapContainer, mapOption);
            var geocoder = new kakao.maps.services.Geocoder();

            var addresses = [
                {
                    address: '서울특별시 강남구 영동대로 513 코엑스 아쿠아리움',
                    popupTitle: '코난',
                    popupContent:'서울의 대표적인 수족관입니다.',
                    image: 'image/Popup/copost3.jpg',
                    date: '2024-00-00',
                    link: '/PopupDetail'
                },
                {
                    address: '서울특별시 영등포구 여의대로 108 파크원 더현대 서울 지하2층 아이코닉존',
                    popupTitle: '지브리',
                    popupContent: '현대적이고 스타일리시한 쇼핑 공간입니다.',
                    image: 'image/Popup/any1.jpg',
                    date: '2024-00-002',
                    link: '/PopupDetail2'
                },
                {
                    address: '서울특별시 용산구 보광로 90 태광빌딩 202호 노노샵',
                    popupTitle: '배틀그라운드',
                    popupContent: '트렌디한 패션 아이템이 가득한 매장입니다.',
                    image: 'image/Popup/battle1.png',
                    date: '2024-00-001',
                    link: '/PopupDetail3'
                },
//                 // 사용하지 않은 주소들
                {
                    address: '제주특별자치도 제주시 공항로 2 제주국제공항 1층 GATE3',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 마포구 양화로 152-6 폴더 오프라인 스토어 홍대점',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 성동구 왕십리로4길 5 한일피복공업(주) 펍지 성수',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 종로구 세종대로 175 세종문화회관 미술관 1, 2관',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 송파구 올림픽로 240 롯데월드',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 마포구 양화로 162 카카오프렌즈 홍대플래그십 스토어',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 송파구 올림픽로 300 롯데월드타워앤드롯데월드몰 지하1층',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '강원특별자치도 양양군 현북면 하조대해안길 119 서피비치 3번 구역',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 종로구 세종대로 175 서울 광화문 광장',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 구로구 경인로 662 디큐브시티 현대백화점 지하1층',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 용산구 한강대로23길 55 용산역 아이파크몰 리빙파크 3층 이벤트홀, A행사장',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '경기도 고양시 덕양구 고양대로 1955 스타필드 고양 1층 센트럴 아트리움',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 송파구 올림픽로 300 롯데월드타워앤드롯데월드몰 1층 아트리움',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 서초구 강남대로 27 AT센터 제2전시장',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '경기도 성남시 분당구 판교역로146번길 20 현대백화점 판교점 5층',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '대구광역시 중구 달구벌대로 2077 현대백화점 대구',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                },
                {
                    address: '서울특별시 강남구 강남대로 470 808타워 아디다스 강남브랜드센터',
                    popupTitle: null,
                    popupContent: null,
                    image: null,
                    date: null,
                    link: null
                }
            ];

            var currentInfowindow = null;

            addresses.forEach(function(info) {
                geocodeAddress(info.address, info.popupTitle, info.popupContent, info.image, info.date, info.link);
            });

            function geocodeAddress(address, popupTitle, popupContent, image, date, link) {
                geocoder.addressSearch(address, function(result, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                        var marker = new kakao.maps.Marker({
                            map: map,
                            position: coords
                        });

                        var content = image ? 
                                '<div class="info-window"><img src="' + image + '" alt="' + address + '"/></div>' : 
                                '<div class="info-window"></div>';

                        var infowindow = new kakao.maps.InfoWindow({
                            content: content
                        });

                        kakao.maps.event.addListener(marker, 'click', function() {
                            if (currentInfowindow) {
                                currentInfowindow.close();
                            }
                            infowindow.open(map, marker);
                            currentInfowindow = infowindow;

                            var popupContainer = document.getElementById('popup-container');
                            var popupContentElement = document.getElementById('popup-content');

                            // date와 link 정보를 포함하여 popupContent를 설정
//                             popupContentElement.innerHTML =
//                             (image ? '<img src="' + image + '" alt="' + address + '" class="popup-image"/>' : '') + 
//                             '<p>Date: ' + date + '</p>'+popupContent;

                            popupContentElement.innerHTML = 
                            	content + 
                            	'<div>' + '<h3>' + popupTitle + '</h3>' + 
                            	'<p>' + popupContent + '</p>' + '<h4>' + address + '</h4>' + 
                            	'<h5>Date: ' + date + '</h5>' + '</div>';
                            


                            popupContainer.style.display = 'block';

                            // 링크 클릭 이벤트를 container 클릭으로 이동
                            if (link) {
                                popupContainer.addEventListener('click', function() {
                                    window.location.href = link;
                                });
                            }
                        });

                        map.setCenter(coords);
                    } else {
                        console.error('주소 변환 실패:', address, status);
                    }
                });
            }
</script>
<br/>
	    <div style="width: 80%; height: 80%; margin:  0px auto;">
	            <br/><br/><br/><br/><br/><br/>
			<h2 class="headline-font1">인기 팝업스토어</h2>
	                <!-- <p>텍스트를 여기에 추가하고, 필요에 따라 스타일을 조정하세요.</p> -->
	            
	            <div class="swiper-container-wrapper">
                <!-- Swiper -->
                <div class="swiper-container1">
                    <div class="swiper-wrapper">
	                    <div class="swiper-slide special-slide">
						        <img src="/image/Popup/any1.jpg">   
						</div>
	                    <div class="swiper-slide special-slide">
	                        	<img src="/image/Popup/game1.jpg">    
	                    </div>
	                    <div class="swiper-slide special-slide">
	                    	<a href="PopupDetail4">
	                        	<img src="/image/Popup/game2.jpg">
	                        </a>     
	                    </div>
	                    <div class="swiper-slide special-slide">
	                        <img src="/image/Popup/sport1.jpg">
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
	            <br/><br/><br/><br/><br/><br/>
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
	<footer>
    <div class="footer-nav">
        <!-- 이용약관 모달 트리거 -->
        <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">이용약관</a>
        <!-- 개인정보처리방침 모달 트리거 -->
        <a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">개인정보처리방침</a>
    </div>
    <div class="footertext" style="color: #3D454A;">
         <p style="color: #3D454A;">셀러브리지 | 대표 김군호 | 팝업코리아 사업본부장 정혜원</p>
	    <p style="color: #3D454A;">주소 서울특별시 서초구 강남대로 373, 위워크 강남 15-111호</p>
	    <p style="color: #3D454A;">사업자등록번호 278-88-02399 | 통신판매업신고번호 제2022-서울서초-2059 호</p>
	    <p style="color: #3D454A;">핸드폰 010-9696-3674 | 이메일 popupkorea@seller-bridge.com</p>
	    <p style="color: #3D454A;">© 셀러브리지 All rights reserved.</p>
    </div>
</footer>
<!-- 이용약관 모달 -->
<div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="termsModalLabel">이용약관</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <img src="../../image/Member/terms.png" alt="이용약관" class="img-fluid" style="max-width: 100%; height: auto;">
            </div>
        </div>
    </div>
</div>

<!-- 개인정보처리방침 모달 -->
<div class="modal fade" id="privacyModal" tabindex="-1" aria-labelledby="privacyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="privacyModalLabel">개인정보처리방침</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <img src="../../image/Member/privacy.png" alt="개인정보처리방침" class="img-fluid" style="max-width: 100%; height: auto;">
            </div>
        </div>
    </div>
</div>
	</body>
</html>