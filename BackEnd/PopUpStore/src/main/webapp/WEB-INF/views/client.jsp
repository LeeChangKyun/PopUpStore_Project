<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
    <title>WebSocket Chat</title>
    <style>
    
    
    /* 푸터 스타일 */
		footer {
		    padding: 10px;
		    text-align: center;
		    background-color: #fff;
		    border-top: none;
		    width: 100%;
		    bottom: 0;
		    left: 0;
		    box-sizing: border-box; /* 패딩을 너비에 포함시킴 */
		    position: fixed; /* 페이지 하단에 고정 */

		}
		
		/* 푸터 내비게이션 스타일 */
		footer .footer-nav {
		    display: flex;
		    justify-content: center;
		    gap: 20px;
		    margin-bottom: 10px;
		}
		
		/* 푸터 내비게이션 링크 스타일 */
		footer .footer-nav a {
		    text-decoration: underline;
		    color: #000; /* 흰색 배경에 맞는 색상 설정 */
		}
        #messages {
            color: white;
            padding: 10px;
            border-radius: 5px;
            max-height: 400px;
            overflow-y: auto;
        }
        body {
           
            color: white;
            font-family: Arial, sans-serif;
        }
        
        .center-content {
            text-align: center;       /* 텍스트 가운데 정렬 */
        }
        input, button {
            margin: 10px 0;
        }
        button {
            padding: 5px 10px;
            background-color: #2980b9;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        button:hover {
            background-color: #3498db;
        }
    </style>
</head>
<body>
    <%
        String id = request.getParameter("id");
        if (id == null) {
    %>
        
    <%
        } else {
            session.setAttribute("uid", id);
        }
    %>
    <br/><br/><br/><br/><br/><br/>
    <div style="display: flex; flex-direction: column; align-items: center;">
    			<h4>반갑습니다.&nbsp<%= id %>님!!</h4>
	    <h6>open을 눌러 관리자에게 문의해주세요!!</h6>
	    <button type="button" onclick="openChatWindow();">Open</button>
	</div>
    <!-- Server responses get written here -->
    <div id="messages"></div>

    <!-- Script to utilize the WebSocket -->
    <script type="text/javascript">
        var webSocket;
        var messages = document.getElementById("messages");

        function openChatWindow() {
            var url = "chatRoom";  // 채팅방 JSP 파일의 경로를 입력하세요
            var chatWindow = window.open(url, "ChatRoom", "width=500,height=800");

            if (!chatWindow || chatWindow.closed || typeof chatWindow.closed == 'undefined') { 
                alert("팝업 차단을 해제해 주세요.");
            }
        }
    </script>
    
    <%@ include file="/WEB-INF/views/Common/footer.jsp" %> 
</body>
</html>