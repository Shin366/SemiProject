<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>에러 발생</title>
  <style>
    body { font-family: 'Noto Sans KR', sans-serif; text-align:center; background:#f8f9fa; color:#333; }
    .container { margin-top: 100px; }
    h1 { color:#d32f2f; }
    a { text-decoration:none; color:#007bff; }
  </style>
</head>
<body>
  <div class="container">
    <h1>⚠️ 오류가 발생했습니다</h1>
    <p>${errorMsg != null ? errorMsg : '일시적인 문제가 발생했습니다. 잠시 후 다시 시도해주세요.'}</p>
    <a href="/">메인으로 돌아가기</a>
  </div>
</body>
</html>
