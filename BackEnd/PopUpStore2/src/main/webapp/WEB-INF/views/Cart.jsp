<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <style>
        body {
            background-color: #343a40;
            color: #fff;
        }
        .container-custom {
            max-width: 1200px;
            margin: 30px auto;
            padding: 20px;
            background-color: #f8f9fa;
            color: #000;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .cart-header {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: #343a40;
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #dee2e6;
            padding: 15px 0;
        }
        .cart-item img {
            width: 100px;
            height: auto;
            margin-right: 15px;
        }
        .cart-item-details {
            flex: 1;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .cart-item-title {
            font-size: 1.2rem;
            margin-bottom: 5px;
        }
        .cart-item-price {
            font-size: 1.2rem;
            color: #dc3545;
        }
        .cart-item-quantity {
            display: flex;
            align-items: center;
        }
        .cart-item-quantity input {
            width: 60px;
            margin-right: 10px;
            text-align: center;
        }
        .cart-summary {
            text-align: right;
            margin-top: 30px;
        }
        .cart-summary p {
            font-size: 1.2rem;
            margin-bottom: 5px;
        }
        .cart-summary-total {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .cart-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .cart-buttons .btn {
            padding: 15px 30px;
            font-size: 1.1rem;
            border-radius: 4px;
        }
    </style>
</head>
<body>
    <div class="container-custom">
        <h2 class="cart-header">장바구니</h2>
        <div class="cart-item">
            <img src="https://via.placeholder.com/100" alt="상품 이미지">
            <div class="cart-item-details">
                <div>
                    <p class="cart-item-title">카카오 캐릭터 굿즈</p>
                    <p class="cart-item-price">22,999원</p>
                </div>
                <div class="cart-item-quantity">
                    <input type="number" value="1" min="1">
                    <button class="btn btn-danger delete-btn">삭제</button>
                </div>
            </div>
        </div>

        <!-- 반복되는 상품 아이템 -->
        <!-- 합계 표시 -->
        <div class="cart-summary">
            <p>상품금액: 28,800원</p>
            <p>할인금액: -5,100원</p>
            <p class="cart-summary-total">합계: 23,700원</p>
        </div>

        <!-- 버튼들 -->
        <div class="cart-buttons">
            <button class="btn btn-secondary continue-shopping-btn">계속 쇼핑하기</button>
            <button class="btn btn-primary order-btn">주문하기</button>
        </div>
    </div>
    
      <%@ include file="/WEB-INF/views/Common/footer.jsp" %> 

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // 장바구니 삭제 버튼 이벤트 리스너 추가
            const deleteButtons = document.querySelectorAll('.delete-btn');
            deleteButtons.forEach(button => {
                button.addEventListener('click', function () {
                    // 삭제 로직 추가 (예: 서버에 요청을 보내고 DOM에서 아이템을 제거)
                    this.closest('.cart-item').remove();
                });
            });

            // 쇼핑 계속하기 버튼 이벤트 리스너
            const continueShoppingButton = document.querySelector('.continue-shopping-btn');
            continueShoppingButton.addEventListener('click', function () {
                window.location.href = '/GoodsShop'; // 쇼핑 페이지로 이동
            });

            // 주문하기 버튼 이벤트 리스너
            const orderButton = document.querySelector('.order-btn');
            orderButton.addEventListener('click', function () {
                window.location.href = '/order'; // 주문 페이지로 이동
            });
        });
    </script>
</body>
</html>
