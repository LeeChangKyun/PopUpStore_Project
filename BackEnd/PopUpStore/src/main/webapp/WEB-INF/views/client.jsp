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
        #messages {
            color: white;
            padding: 10px;
            border-radius: 5px;
            max-height: 400px;
            overflow-y: auto;
            background-color: #333; /* 어두운 배경 추가 */
        }
        body {
           
            color: white;
            font-family: Arial, sans-serif;
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
        <jsp:forward page="login1.jsp"/>
    <%
        } else {
            session.setAttribute("uid", id);
        }
    %>
    <div>
        사용자 아이디: <%= id %>
    </div>
   
    <div>
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
            var chatWindow = window.open(url, "ChatRoom", "width=400,height=500");

            if (!chatWindow || chatWindow.closed || typeof chatWindow.closed == 'undefined') { 
                alert("팝업 차단을 해제해 주세요.");
            }
        }
    </script>
    
    <%@ include file="/WEB-INF/views/Common/footer.jsp" %> 
</body>
</html>