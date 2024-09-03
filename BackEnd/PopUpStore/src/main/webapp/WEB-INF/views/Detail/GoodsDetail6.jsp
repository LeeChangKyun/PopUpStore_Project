<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>GoodsDetail</title>
	    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
		<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
		<style>
		.image-section {
            position: relative;
            width: 100%;
            max-width: 400px;
            margin: 20px 0;
        }
        .image-section img {
            width: 100%;
            cursor: pointer;
        }
        .image-section button {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background-color: rgba(0, 0, 0, 0.5);
            border: none;
            color: white;
            font-size: 18px;
            padding: 10px;
            cursor: pointer;
        }
        .prev-btn {
            left: 0;
        }
        .next-btn {
            right: 0;
        }
        .details-section {
            flex: 1;
            padding: 20px;
            color: #fff;
        }
        .details-section h1 {
            font-size: 24px;
            margin-bottom: 10px;
        }
        .price {
            color: red;
            font-size: 24px;
            margin: 10px 0;
        }
        .old-price {
            text-decoration: line-through;
        }
        .shipping-info, .seller-info, .delivery-info, .quantity-info, .points-info {
            margin: 10px 0;
        }
        .buttons {
            display: flex;
            margin-top: 20px;
        }
        .buttons button {
            flex: 1;
            padding: 10px;
            margin: 5px;
            font-size: 16px;
            cursor: pointer;
        }
        .cart-btn {
            background-color: #f0f0f0;
        }
        .buy-btn {
            background-color: #f0f0f0;
            color: black;
        }
        .container {
            width: 80%;
            margin: auto;
            display: flex;
            flex-direction: column;
            align-items: center;
            border-radius: 15px; /* 모서리 둥글게 만들기 */
    		overflow: hidden; /* 내용이 모서리를 넘지 않도록 숨기기 */
        }
		
		</style>
	</head>
<body>
    

    <div class="container">
        <div class="image-section">
            <button class="prev-btn">&lt;</button>
            <img id="main-image" src="image/Goods/Goods1.jpg" alt="Product Image" style="border-radius: 15px;">
            <button class="next-btn">&gt;</button>
        </div>
       <div class="bg-dark text-white" style="width: 50%; margin: 0 auto; border-radius: 15px;">
        <div class="details-section">
            <h1>스누피 캐릭터 굿즈</h1>
            <div class="price">
                <span class="old-price">98,800원</span>
                <span>19,000원</span>
            </div>
            <div class="quantity-info">
                총 수량: 5개입
            </div>
            <div class="buttons">
                <button class="cart-btn">장바구니 담기</button>
                <button class="buy-btn">바로구매</button>
            </div>
            <div class="shipping-info">
                <h5>상품설명</h5><br><br/>
                <p>귀여운 스누피 키링입니다~~~!!!!</p>
            </div>
        </div>
        </div>
        <br/>
    </div>
  <%@ include file="/WEB-INF/views/Common/footer.jsp" %> 

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const images = [
                'image/Goods/Goods5.jpg',
                'image/Goods/goods9.jpg',
                'image/Goods/Goods7.jpg'
            ];
            let currentIndex = 0;

            const mainImage = document.getElementById('main-image');
            const prevBtn = document.querySelector('.prev-btn');
            const nextBtn = document.querySelector('.next-btn');

            prevBtn.addEventListener('click', function () {
                currentIndex = (currentIndex - 1 + images.length) % images.length;
                mainImage.src = images[currentIndex];
            });

            nextBtn.addEventListener('click', function () {
                currentIndex = (currentIndex + 1) % images.length;
                mainImage.src = images[currentIndex];
            });
        });
    </script>
</body>
</html>