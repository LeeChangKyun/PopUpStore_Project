<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Room</title>
    <style>
        #messages {
            color: white; /* 텍스트 색상 흰색 */
            padding: 10px; /* 여백 추가 */
            border-radius: 5px; /* 모서리 둥글게 */
            max-height: 400px; /* 최대 높이 설정 */
            overflow-y: auto; /* 스크롤바 자동 표시 */
            background-color: #333; /* 배경 색상 어둡게 */
        }
        body {
            background-color: #2c3e50;
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
    <h2>Chat Room</h2>
    <div>
        사용자 아이디: <span id="userId"><%= session.getAttribute("uid") %></span>
    </div>
    <div>
        타겟 사용자 아이디: <input type="text" id="targetUser" placeholder="타겟 사용자 아이디" />
    </div>
    <div>
        <input type="text" id="messageinput" placeholder="메시지를 입력하세요" />
    </div>
    <div>
        <button type="button" onclick="send();">Send</button>
        <button type="button" onclick="closeSocket();">Close</button>
        <button type="button" onclick="openChatWindow();">Open Chat Window</button>
    </div>
    <!-- Server responses get written here -->
    <div id="messages"></div>

    <!-- WebSocket을 이용한 채팅 기능 구현 -->
    <script type="text/javascript">
        var webSocket;
        var messages = document.getElementById("messages");
        var userId = document.getElementById("userId").textContent.trim(); // 사용자 ID 가져오기
        var targetUserInput = document.getElementById("targetUser");

        // WebSocket 연결 열기
        function openSocket() {
            if (webSocket !== undefined && webSocket.readyState !== WebSocket.CLOSED) {
                writeResponse("WebSocket is already opened.");
                return;
            }

            // 현재 사용자 ID로 WebSocket 연결
            webSocket = new WebSocket("ws://localhost:8081/websocketendpoint/" + userId);
            
            webSocket.onopen = function(event) {
                writeResponse("WebSocket connection opened.");
            };
            
            webSocket.onmessage = function(event) {
                writeResponse(event.data);
            };
            
            webSocket.onclose = function(event){
                writeResponse("Connection closed");
            };
        }

        // 메시지 전송
        function send() {
            var text = document.getElementById("messageinput").value;
            var targetUser = targetUserInput.value; // 타겟 사용자 ID
            if (webSocket && webSocket.readyState === WebSocket.OPEN) {
                webSocket.send(targetUser + "|" + text);
                document.getElementById("messageinput").value = ''; // 메시지 전송 후 입력 필드 비우기
            } else {
                writeResponse("WebSocket is not open.");
            }
        }

        // WebSocket 연결 닫기
        function closeSocket() {
            if (webSocket && webSocket.readyState === WebSocket.OPEN) {
                webSocket.close();
            } else {
                writeResponse("WebSocket is not open.");
            }
        }

        // 메시지 출력
        function writeResponse(text) {
            messages.innerHTML += "<br/>" + text;
        }

        // 페이지 로드 시 WebSocket 연결 자동으로 열기 및 사용자 유형에 따른 처리
        window.onload = function() {
            openSocket();

            // 사용자 ID가 'Admin'이 아닌 경우 타겟 사용자 고정
            if (userId !== "관리자") {
                targetUserInput.value = "관리자";
                targetUserInput.disabled = true; // 입력 비활성화
            } else {
                targetUserInput.disabled = false; // 입력 활성화
            }
        };

        // 채팅방 창 열기
        function openChatWindow() {
            var url = "chatRoom";  // 채팅방 JSP 파일의 경로를 입력하세요
            var chatWindow = window.open(url, "ChatRoom", "width=400,height=500");

            if (!chatWindow || chatWindow.closed || typeof chatWindow.closed == 'undefined') { 
                alert("팝업 차단을 해제해 주세요.");
            }
        }
    </script>
</body>
</html>
