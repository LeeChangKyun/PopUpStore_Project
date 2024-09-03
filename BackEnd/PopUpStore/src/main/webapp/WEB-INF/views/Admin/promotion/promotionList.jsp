<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/adminheader.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Custom Header</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <style>
        
        .dropdown-toggle::after {
            content: none;
        }
        .dropdown-menu .dropdown-item {
            color: black;
        }
        .dropdown-menu .dropdown-item:hover {
            background-color: #060606;
            color: #fff;
            padding: 5px 10px;
        }
       
        .table-container {
            margin: 20px auto;
            max-width: 800px;
        }
        .table thead {
            background-color: #343a40;
            color: #fff;
        }
        .table td, .table th {
            vertical-align: middle;
            font-size: 14px;
        }
        .table th.title-column {
            color: #000 !important;
        }
        .table td a, .table td a:visited {
            color: #000 !important;
        }
        .table td a:hover {
            color: #000 !important;
        }
        .stats {
            font-size: 12px;
            color: #6c757d;
        }
        
         .pagination-container {
        margin-top: 20px;
        margin-bottom: 20px;
	    }
	
	    .pagination .page-item.disabled .page-link {
	        background-color: #f8f9fa;
	        border-color: #dee2e6;
	        color: #6c757d;
	    }
	
	       /* 검색 폼 스타일 */
    .search-form {
        max-width: 500px;
        margin: 0 auto;
    }

    .input-group {
        border-radius: 0.375rem; /* Bootstrap 기본 border-radius */
    }

    .form-select, .form-control {
        border-radius: 0;
    }

    .input-group .form-select {
        border-top-right-radius: 0;
        border-bottom-right-radius: 0;
    }

    .input-group .form-control {
        border-top-left-radius: 0;
        border-bottom-left-radius: 0;
    }

    .input-group .btn-primary {
        border-top-left-radius: 0;
        border-bottom-left-radius: 0;
    }

    .btn-primary {
        background-color: #007bff;
        border-color: #007bff;
    }

    .btn-primary:hover {
        background-color: #0056b3;
        border-color: #004085;
    }
    
  .write-button {
    margin-top: 20px;
    text-align: right; /* 오른쪽 정렬 */
    margin-right: 10px; /* 오른쪽으로 이동할 거리 */
}
	 
    </style>
</head>
<body>
    <div class="table-container">
        <h1 style="color: #fff; text-align: center;">홍보 게시판</h1>
        <table class="table table-secondary table-hover">
            <thead class="text-center">
		                <tr>
				            <th width="10%">번호</th>
				            <th width="*">제목</th>
				            <th width="15%">작성자</th>
				            <th width="10%">조회수</th>
				            <th width="15%">작성일</th>
				            <th width="10%">관리</th>
				        </tr>
             </thead>
             <tbody>
				<c:choose>
				    <c:when test="${ empty lists }"> 
				        <tr>
				            <td colspan="5" align="center">
				                등록된 게시물이 없습니다^^*
				            </td>
				        </tr>
				    </c:when> 
				    <c:otherwise> 
				        <c:forEach items="${ lists }" var="row" varStatus="loop">    
				        <tr align="center">
				            <td> 
				            <!-- 게시물의갯수, 페이지번호, 페이지사이즈를 통해 가상번호를 계산해서
				            출력한다. -->
				            <c:set var="vNum" value="${ maps.totalCount - 
				                (((maps.pageNum-1) * maps.pageSize)	+ loop.index)}" />
				            	${vNum}
				            </td>
				            <td align="center"> 
				                <a href="/Admin/promotionView?promotion_num=${row.promotion_num}&vNum=${vNum}">${ row.promotion_title }</a> 
				            </td> 
				            <td>${ row.user_nick }</td> 
				            <td>${ row.visitcount }</td> 
				            <td>${ row.promotion_create_date }</td>
				            <td>
                                <form action="<%=request.getContextPath()%>/Admin/promotionDelete" method="post" onsubmit="return confirmDelete();">
                               	    <input type="hidden" name="promotion_num" value="${row.promotion_num}">
                                    <button type="submit" class="btn btn-danger btn-sm">삭제</button>
                                </form>
                            </td> 
				        </tr>
				        </c:forEach>       
				    </c:otherwise>    
				</c:choose>
            </tbody>
        </table>
   <div class="write-button">
            <button type="button" class="btn btn-primary" onclick="location.href='/Admin/promotionWrite';">글쓰기</button>
   </div>
    </div>
	<!-- 페이지 네비게이션 -->
	<div class="pagination-container mb-4">
	    <nav aria-label="Page navigation">
	        <ul class="pagination justify-content-center">
	            <c:if test="${not empty pagingImg}">
	                ${pagingImg}
	            </c:if>
	            <c:if test="${empty pagingImg}">
	                <li class="page-item disabled">
	                    <span class="page-link">페이지 네비게이션 정보가 없습니다.</span>
	                </li>
	            </c:if>
	        </ul>
	    </nav>
	</div>

<!-- 검색 폼 -->
<form method="get" class="mb-4">
    <div class="container">
        <div class="row justify-content-center">
             <div class="col-md-6 col-lg-5">
                <div class="input-group">
                    <select name="searchField" class="form-select">
                        <option value="promotion_title">제목</option>
                        <option value="user_nick">작성자</option>
                    </select>
                    <input type="text" name="searchKeyword" class="form-control" placeholder="검색어를 입력하세요">
                    <button type="submit" class="btn btn-primary">검색하기</button>
                </div>
            </div>
        </div>
    </div>
</form>
<!--     푸터--------------------------------------------------- -->
    	<%@ include file="/WEB-INF/views/Common/footer.jsp" %> 
	
	    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
	
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
	        
	        // 삭제 버튼 눌렀을시 스크립트
	        function confirmDelete() {
	            return confirm("정말로 삭제 하시겠습니까?");
	        }
	    
	        // 삭제 완료 후 메시지 표시
	        <c:if test="${not empty successMessage}">
	            alert("${successMessage}");
	        </c:if>
	        
	    </script>
</body>
</html>


