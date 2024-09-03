<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/adminheader.jsp" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/Adminstyle.css">

    <style>
        /* '모든 유저 정보'에만 스타일 적용 */
        .user-info-title {
            color: white;
            margin-top: 20px; /* 상단 여백 추가 */
            text-align: center; /* 중앙 정렬 */
        }

        /* 검색바 스타일 */
        .input-group {
            margin-bottom: 20px; /* 검색바 하단에 마진 추가 */
            justify-content: center; /* 중앙 정렬 */
            width: 50%; /* 검색바 전체 너비 조정 */
            margin-left: auto;
            margin-right: auto;
        }

        /* 검색바 옵션 크기 조정 */
        .input-group select.form-select {
            width: 120px; /* 옵션 선택 크기를 줄임 */
            padding: 0.375rem 0.75rem; /* 기본 패딩 */
        }

        .input-group input.form-control {
            width: 60%; /* 검색창의 너비를 줄여줌 */
        }

        .input-group button.btn {
            width: 80px; /* 검색 버튼 크기 조정 */
            background-color: #28a745; /* 버튼 배경색 초록색으로 변경 */
            color: white; /* 버튼 텍스트 색상 흰색으로 변경 */
            border-color: #28a745; /* 버튼 테두리 색상도 동일하게 변경 */
        }

        .input-group button.btn:hover {
            background-color: #218838; /* 버튼 호버 시 조금 더 어두운 초록색 */
            border-color: #1e7e34; /* 호버 시 테두리 색상 */
        }

        /* 테이블과 검색바의 간격 조정 */
        .table {
            width: 95%;
            margin-left: auto;
            margin-right: auto;
            margin-bottom: 20px;
        }

        /* 테이블 셀 패딩과 정렬 */
		.table td, .table th {
		    padding: 8px 12px;
		    text-align: center; /* 셀 내용 가운데 정렬 */
		    vertical-align: middle; /* 수직 가운데 정렬 */
		}
		
		/* 삭제 버튼 중앙 정렬 */
		.table td form {
		    display: inline-block;
		    vertical-align: middle;
		}
		
		.table td form button {
		    display: block;
		    margin: 0 auto; /* 버튼이 수평 중앙에 오도록 설정 */
		    height: 100%; /* 셀 높이에 맞춤 */
		}
    </style>    
        
</head>    
<body>
    <div class="container-fluid">
        <h2 class="user-info-title">모든 유저 정보</h2>
        
        <form action="<%=request.getContextPath()%>/Admin/profile/search" method="get" class="mb-4">
            <div class="input-group">
                <select class="form-select" name="searchType">
                    <option value="id">ID</option>
                    <option value="nickname">닉네임</option>
                </select>
                <input type="text" name="query" placeholder="검색어 입력" class="form-control">
                <button type="submit" class="btn">검색</button>
            </div>
        </form>
        
        <div class="table-container" style="flex: 1; overflow-y: auto;">
            <table class="table table-bordered table-sm mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>닉네임</th>
                        <th>이메일</th>
                        <th>전화번호</th>
                        <th>주소</th>
                        <th>가입일자</th>
                        <th>관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty users}">
                        <!-- ID가 Admin인 사용자 -->
                        <c:forEach var="user" items="${users}">
                            <c:if test="${user.userId == 'Admin'}">
                                <tr>
                                    <td>${user.userId}</td>
                                    <td>${user.userNick}</td>
                                    <td>${user.userEmail}</td>
                                    <td>
									    <c:out value="${fn:substring(user.userPhone, 0, 3)}-${fn:substring(user.userPhone, 3, 7)}-${fn:substring(user.userPhone, 7, 11)}" />
									</td>
                                    <td>${user.userAddress}</td>
                                    <td>${user.userCreatedate}</td>
                                    <td></td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        
                        <!-- 그 외 사용자 -->
                        <c:forEach var="user" items="${users}">
                            <c:if test="${user.userId != 'Admin'}">
                                <tr>
                                    <td>${user.userId}</td>
                                    <td>${user.userNick}</td>
                                    <td>${user.userEmail}</td>
                                    <td>
									    <c:out value="${fn:substring(user.userPhone, 0, 3)}-${fn:substring(user.userPhone, 3, 7)}-${fn:substring(user.userPhone, 7, 11)}" />
									</td>
                                    <td>${user.userAddress}</td>
                                    <td>${user.userCreatedate}</td>
                                    <td>
                                        <form action="<%=request.getContextPath()%>/Admin/profile/Withdraw" method="post" onsubmit="return confirmDelete();">
                                            <input type="hidden" name="userId" value="${user.userId}">
                                            <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="7">No users found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    
<%@ include file="/WEB-INF/views/Common/footer.jsp" %> 

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

    <script>
        function confirmDelete() {
            return confirm("정말로 삭제 하시겠습니까?");
        }
    
        // 삭제 완료 후 메시지 표시
        <c:if test="${not empty successMessage}">
            alert("${successMessage}");
        </c:if>
    
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
    
</body>
</html>