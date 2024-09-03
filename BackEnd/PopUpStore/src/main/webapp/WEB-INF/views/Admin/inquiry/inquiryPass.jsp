<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/views/Common/adminheader.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>문의 게시판</title>
    <script type="text/javascript">
    function validateForm(form) {
        // 비밀번호가 필수로 입력되어야 하는 경우
        if (form.pass.value.trim() === "") {
            // 비밀번호가 빈 문자열일 경우에 대한 추가 처리
            alert("비밀번호를 입력하세요.");
            form.pass.focus();
            return false;
        }
        return true;
    }
</script>
</head>
<body>
    <h2>파일 첨부형 게시판 - 비밀번호 검증</h2>
    <form name="writeFrm" method="post" action="/pass" onsubmit="return validateForm(this);">
        <input type="hidden" name="inquiry_num" value="${ param.inquiry_num }" />
        <input type="hidden" name="mode" value="${ param.mode }" />

        <!-- 에러 메시지 출력 부분 -->
        <c:if test="${not empty error}">
            <div style="color: red;">
                ${error}
            </div>
        </c:if>

        <table border="1" width="90%">
            <tr>
                <td>비밀번호</td>
                <td>
                    <input type="password" name="pass" style="width:150px;" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <button type="submit">검증하기</button>
                    <button type="reset">RESET</button>
                    <button type="button" onclick="location.href='/list';">
                        목록 바로가기
                    </button>
                </td>
            </tr>
        </table>    
    </form>
    <%@ include file="/WEB-INF/views/Common/footer.jsp" %>
</body>
</html>
