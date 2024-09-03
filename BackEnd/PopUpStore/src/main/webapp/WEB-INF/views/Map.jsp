<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %> <!-- 헤더 파일 포함 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <title>MapPage</title>
    <style>
    
    
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
        
        body {
            /* 페이지의 전체 배경색을 어두운 회색으로 설정 */
            background-color: #343a40;
            margin: 0;
            flex-direction: column;
            
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
            color: #fff;
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
            color: #fff;
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
		    /* 본문 내용과 푸터 사이의 여백을 추가하여 푸터가 페이지 하단에 위치하도록 함 */
		    padding-bottom: 80px; /* 푸터의 높이만큼 여백 추가 */
		}
		
		
		
        footer {
            /* 푸터의 상하 패딩 설정, 텍스트 중앙 정렬, 배경색 및 경계선 제거 */
           padding: 20px;
		    text-align: center;
		    background-color: #343a40;
		    border-top: none;
		    width: 100%;
		    position: relative; /* 문서 흐름에 맞게 배치 */
        }

        footer p {
            /* 푸터의 문단 여백을 줄이고, 텍스트 색상을 흰색으로 설정 */
            margin: 5px 0;
            color: #fff;
        }

        footer .footer-nav {
            /* 푸터 내비게이션의 항목들을 가로로 배치하고, 간격을 설정 */
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 10px;
        }

        footer .footer-nav a {
            /* 푸터 내비게이션 링크에 밑줄을 추가하고, 텍스트 색상을 흰색으로 설정 */
            text-decoration: underline;
            color: #fff;
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
    display: none;
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
}
	
	

    </style>
</head>
<body>
    <main class="container my-4">
        <section class="text-center my-5">
            <h2>전국 팝업스토어</h2>
            <!-- <p>텍스트를 여기에 추가하고, 필요에 따라 스타일을 조정하세요.</p> -->
        </section>
    <div id="map" style="position:relative;">
    
    
        <div id="popup-container" style="display:none; position:absolute; background-color:white; border:1px solid #ccc; padding:10px; z-index:2000; max-width:300px;">
        <button onclick="closePopup()">Close</button>
        <div id="popup-content"></div>
  	  </div>
    </div>
    
    
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5a4f12f046988db3dab2b83e5335845d&libraries=services"></script>
    <script>
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 8 // 지도의 확대 레벨
            };  

        // 지도를 생성합니다    
        var map = new kakao.maps.Map(mapContainer, mapOption); 

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 여러 주소를 배열로 저장합니다
        var addresses = [
            '서울특별시 강남구 영동대로 513 코엑스 아쿠아리움',
            '서울특별시 영등포구 여의대로 108 파크원 더현대 서울 지하2층 아이코닉존',
            '제주특별자치도 제주시 공항로 2 제주국제공항 1층 GATE3',
            '서울특별시 마포구 양화로 152-6 폴더 오프라인 스토어 홍대점',
            '서울특별시 용산구 보광로 90 태광빌딩 202호 노노샵',
            '서울특별시 성동구 왕십리로4길 5 한일피복공업(주) 펍지 성수',
            '서울특별시 종로구 세종대로 175 세종문화회관 미술관 1, 2관',
            '서울특별시 송파구 올림픽로 240 롯데월드',
            '서울특별시 마포구 양화로 162 카카오프렌즈 홍대플래그십 스토어',
            '서울특별시 송파구 올림픽로 300 롯데월드타워앤드롯데월드몰 지하1층',
            '강원특별자치도 양양군 현북면 하조대해안길 119 서피비치 3번 구역',
            '서울특별시 종로구 세종대로 175 서울 광화문 광장',
            '서울특별시 구로구 경인로 662 디큐브시티 현대백화점 지하1층',
            '서울특별시 용산구 한강대로23길 55 용산역 아이파크몰 리빙파크 3층 이벤트홀, A행사장',
            '경기도 고양시 덕양구 고양대로 1955 스타필드 고양 1층 센트럴 아트리움',
            '서울특별시 송파구 올림픽로 300 롯데월드타워앤드롯데월드몰 1층 아트리움',
            '서울특별시 서초구 강남대로 27 AT센터 제2전시장',
            '경기도 성남시 분당구 판교역로146번길 20 현대백화점 판교점 5층',
            '대구광역시 중구 달구벌대로 2077 현대백화점 대구',
            '서울특별시 강남구 강남대로 470 808타워 아디다스 강남브랜드센터'
        ];

        // 각 주소에 대해 geocode를 수행합니다
        for (var i = 0; i < addresses.length; i++) {
            geocodeAddress(addresses[i]);
        }

        function geocodeAddress(address) {
            geocoder.addressSearch(address, function(result, status) {
                // 정상적으로 검색이 완료됐으면 
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    // 결과값으로 받은 위치를 마커로 표시합니다
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    var content = '';
                    if (address === '서울특별시 강남구 영동대로 513 코엑스 아쿠아리움') {
                        content = '<div class="info-window"><img src="image/Popup/copost3.jpg" alt="코엑스 아쿠아리움"/></div>';
                    } else {
                        content = '<div class="info-window"></div>';
                    }

                    var infowindow = new kakao.maps.InfoWindow({
                        content: content
                    });

                    kakao.maps.event.addListener(marker, 'click', function() {
                        infowindow.open(map, marker);
                        if (address === '서울특별시 강남구 영동대로 513 코엑스 아쿠아리움') {
                            var mapContainer = document.getElementById('map');
                            var popupContainer = document.getElementById('popup-container');
                            var popupContent = document.getElementById('popup-content');

                            popupContent.innerHTML = '<h3>' + address + '</h3><p>여기에 설명을 추가합니다.</p>';

                            // popup-container를 하단에 위치시키기
                            popupContainer.style.display = 'block';
                            popupContainer.style.bottom = '10px'; // 하단에서 10px 떨어진 위치
                            popupContainer.style.left = '50%'; // 수평 가운데 정렬
                            popupContainer.style.transform = 'translateX(-50%)'; // 수평 가운데 정렬
                        }
                    });

//                     kakao.maps.event.addListener(marker, 'click', function() {
//                         if (address === '서울특별시 강남구 영동대로 513 코엑스 아쿠아리움') {
//                             window.location.href = '/PopupDetail?address=' + encodeURIComponent(address);
//                         }
//                     });


                    // 지도의 중심을 마지막 주소의 위치로 이동시킵니다
                    map.setCenter(coords);
                } else {
                    console.error('주소 변환 실패:', address, status);
                }
            });
        }
        
        function showPopup(title, description) {
            var popupContainer = document.getElementById('popup-container');
            var popupContent = document.getElementById('popup-content');

            popupContent.innerHTML = '<h3>' + title + '</h3><p>' + description + '</p>';
            popupContainer.style.display = 'block';
            popupContainer.style.top = '10px'; // 위치 조정 필요
            popupContainer.style.left = '10px'; // 위치 조정 필요
        }

        function closePopup() {
            document.getElementById('popup-container').style.display = 'none';
        }
    </script>
    </main>
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
