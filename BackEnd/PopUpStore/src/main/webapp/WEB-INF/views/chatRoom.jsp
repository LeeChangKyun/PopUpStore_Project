<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chat Room</title>
    <style>
       body {
            background-color: #3D454A;
            font-family: 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }
        #header {
            background-color: white;
            color: #3D454A;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        #chatContainer {
            display: flex;
            flex-direction: column;
            flex: 1;
            padding: 10px;
            overflow-y: auto;
            scrollbar-width: none; /* Firefox */
            -ms-overflow-style: none; /* IE 10+ */
        }
        #chatContainer::-webkit-scrollbar {
            display: none; /* Chrome, Safari, Opera*/
        }
        .message {
            display: flex;
            margin-bottom: 10px;
            padding: 5px;
            max-width: 70%;
        }
        .message.sent {
           justify-content: flex-end; /* 메시지를 오른쪽으로 정렬 */
            align-self: flex-end; /* 메시지를 컨테이너의 오른쪽에 붙임 */
        }
        .message.received {
            justify-content: flex-start;
        }
        .message .bubble {
            padding: 10px;
            border-radius: 10px;
            position: relative;
        }
        .message.sent .bubble {
            background-color: white;
            text-align: right;
        }
        .message.received .bubble {
            background-color: #fff;
        }
        #inputContainer {
            display: flex;
            align-items: center;
            padding: 10px;
            background-color: #fff;
            border-top: 1px solid #ddd;
        }
        #messageinput {
            flex: 1;
            padding: 10px;
            border-radius: 20px;
            border: none;
            background-color: white;
            font-size: 16px;
            margin-right: 10px;
        }
        #sendButton {
            background-color: #075E54;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div id="header">
        <div>
            보내는이: <span id="userId"><%= session.getAttribute("uid") %></span>
        </div>
        <div>
            받는이: <input type="text" id="targetUser" placeholder="타겟 사용자 아이디" />
        </div>
    </div>

    <div id="chatContainer">
        <!-- Messages will be displayed here -->
    </div>

    <div id="inputContainer">
        <input type="text" id="messageinput" placeholder="메시지를 입력하세요" />
        <button id="sendButton" onclick="send();">></button>
    </div>

    <script type="text/javascript">
        var webSocket;
        var chatContainer = document.getElementById("chatContainer");

        function openSocket() {
            var userId = '<%= session.getAttribute("uid") %>';
            webSocket = new WebSocket("ws://localhost:8081/websocketendpoint/" + userId);

            webSocket.onmessage = function(event) {
                receiveMessage(event.data);
            };
        }

        function send() {
            var text = document.getElementById("messageinput").value;
            var targetUser = document.getElementById("targetUser").value; // 타겟 사용자 ID
            
            if (text.trim() === '') return;

            webSocket.send(targetUser + "|" + text);
            appendMessage("나: " + text, 'sent');
            document.getElementById("messageinput").value = ''; // Clear input
        }

        function receiveMessage(text) {
            writeResponse(text); // 받은 메시지를 writeResponse 함수로 처리
        }

        // 메시지 출력
        function writeResponse(text) {
            // 정규 표현식을 사용하여 'From <이름>:' 부분을 '상대방:'으로 교체
            var modifiedText = text.replace(/^From\s.*?:/, "상대방:");
            appendMessage(modifiedText, 'received');
        }

        function appendMessage(text, type) {
            var messageDiv = document.createElement('div');
            messageDiv.className = 'message ' + type;
            var bubbleDiv = document.createElement('div');
            bubbleDiv.className = 'bubble';
            bubbleDiv.textContent = text;

            messageDiv.appendChild(bubbleDiv);
            chatContainer.appendChild(messageDiv);
            chatContainer.scrollTop = chatContainer.scrollHeight; // Scroll to the bottom
        }

        window.onload = function() {
            openSocket();
            var userId = '<%= session.getAttribute("uid") %>';

            // 사용자 ID가 'Admin'이 아닌 경우 타겟 사용자 고정
            if (userId !== "Admin") {
                document.getElementById("targetUser").value = "Admin";
                document.getElementById("targetUser").disabled = true; // 입력 비활성화
            }

            // 엔터키로 메시지 전송
            document.getElementById("messageinput").addEventListener("keydown", function(event) {
                if (event.key === "Enter") {
                    send();
                }
            });
        };
    </script>
</body>
</html>
