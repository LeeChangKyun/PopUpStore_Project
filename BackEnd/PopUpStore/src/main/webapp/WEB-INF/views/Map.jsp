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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
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

    </style>
</head>
<body>
    <main class="container my-4">
        <section class="text-center my-5">
            <h2>전국 팝업스토어</h2>
            <!-- <p>텍스트를 여기에 추가하고, 필요에 따라 스타일을 조정하세요.</p> -->
        </section>
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