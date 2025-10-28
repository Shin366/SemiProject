<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<style>
    body { font-family: sans-serif; background-color: #f8f9fa; }
    .wrapper { width: 400px; margin: 120px auto; background: #fff; border-radius: 8px; box-shadow: 0 3px 10px rgba(0,0,0,0.1); padding: 40px; text-align: center; }
    input[type=password] { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; margin-bottom: 20px; }
    button { background-color: #007bff; border: none; color: white; padding: 12px 30px; border-radius: 6px; cursor: pointer; font-weight: bold; }
    button:hover { background-color: #0056b3; }
    .error { color: red; font-size: 0.9em; margin-bottom: 10px; }
</style>
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
