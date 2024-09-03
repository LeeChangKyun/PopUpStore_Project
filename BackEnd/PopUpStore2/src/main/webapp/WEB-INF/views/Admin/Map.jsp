<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/adminheader.jsp" %> <!-- 헤더 파일 포함 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <title>MapPage</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #e6ebef;
        }
        header {
            position: sticky;
            top: 0;
            z-index: 1000;
            background-color: #343a40;
            border: none;
            padding: 15px;
        }

        .nav {
            display: flex;
            gap: 50px;
            align-items: center; /* 수직 정렬 */
            justify-content: center; /* 수평 가운데 정렬 */
            flex-grow: 1; /* 공간 차지 */
        }
        .nav a, .nav .dropdown-toggle {
            text-decoration: none;
            color: #fff; /* 헤더 폰트 색 */
            font-size: 16px;
            position: relative;
            background: none;
            display: flex;
            align-items: center;
            line-height: 1.5; /* 행간 조정 */
            letter-spacing: 0.5px; /* 자간 조정 */
        }
        .nav .dropdown-menu {
            display: none; /* 기본적으로 숨김 */
            position: absolute; /* 위치를 절대적으로 설정 */
            left: 50%; /* 왼쪽을 50%로 설정 */
            transform: translateX(-50%); /* 왼쪽 위치의 50%만큼 왼쪽으로 이동 */
            top: 100%; /* 드롭다운 메뉴를 버튼 아래에 위치 */
            z-index: 1000; /* 다른 요소 위에 보이도록 설정 */
        }
        .nav .dropdown-menu.show {
            display: block; /* 클래스가 show인 경우 보이게 설정 */
        }
        .nav a:last-child {
            margin-left: -5px; /* 원하는 간격으로 조정 */
        }
        .nav a.beta {
            color: #2196F3;
            background-color: #E3F2FD;
            padding: 3px 5px;
            border-radius: 3px;
        }
        .nav .dropdown-toggle {
            outline: none;
            box-shadow: none;
            border-color: transparent;
        }
        .nav .dropdown-toggle:hover {
            color: #2196F3; /* 마우스를 올렸을 때 글자색 변경 */
        }
        .auth {
            display: flex;
            gap: 15px; /* 로그인 버튼과의 간격 조정 */
            margin-left: 20px; /* 로그인 버튼과의 간격 조정 */
        }
        .auth a {
            text-decoration: none;
            color: #fff; /* 로그인 텍스트 색상 */
            font-size: 16px;
            display: flex;
            align-items: center;
        }
        .auth button {
            background: none; /* 버튼 배경 없애기 */
            border: none; /* 버튼 경계선 없애기 */
            padding: 0; /* 패딩 없애기 */
            cursor: pointer; /* 커서 모양 변경 */
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
        footer {
            background-color: #000; /* 배경색을 bg-dark 클래스로 변경하였으므로 주석 처리 */
            color: #fff; /* 글자 색상을 흰색으로 변경 */
            padding: 20px;
            text-align: center;
            border-top: 1px solid #ddd;
        }
        footer p {
            margin: 5px 0;
        }
        footer .footer-nav {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 10px;
            text-decoration: underline;
        }
        footer .footer-nav a {
            text-decoration: none;
            color: #fff; /* 링크 색상을 흰색으로 변경 */
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

    </style>
</head>
<body>
    <main class="container my-4">
        <section class="text-center my-5">
            <h2>전국 팝업스토어</h2>
            <!-- <p>텍스트를 여기에 추가하고, 필요에 따라 스타일을 조정하세요.</p> -->
        </section>
    <div id="map"></div>
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

                    // 인포윈도우로 장소에 대한 설명을 표시합니다
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div>' + address + '</div>'
                    });

                    kakao.maps.event.addListener(marker, 'mouseover', function() {
                        infowindow.open(map, marker);
                    });

                    kakao.maps.event.addListener(marker, 'mouseout', function() {
                        infowindow.close();
                    });

                    // 지도의 중심을 마지막 주소의 위치로 이동시킵니다
                    map.setCenter(coords);
                } else {
                    console.error('주소 변환 실패:', address, status);
                }
            });
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
