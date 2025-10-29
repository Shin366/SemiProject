<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<link rel="stylesheet" href="<c:url value='/resources/css/board/report/password.css'/>"> 
</head>
<body>
    <div class="wrapper">
        <h2>비밀번호 확인</h2>
        <form action="/board/report/detail" method="get">
            <input type="hidden" name="reportNo" value="${reportNo}">
            <input type="password" name="reportPassword" placeholder="비밀번호를 입력하세요" required>
            <button type="submit">확인</button>
            <c:if test="${not empty errorMsg}">
                <p class="error">${errorMsg}</p>
            </c:if>
        </form>
    </div>
</body>
</html>
