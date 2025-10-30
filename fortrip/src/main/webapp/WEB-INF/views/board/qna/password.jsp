<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>비밀글 비밀번호 확인</title>
<link rel="stylesheet" href="<c:url value='/resources/css/board/qna/password.css'/>"> 
</head>
<body>
	<div class="wrapper">
	  <h2>비밀글입니다.</h2>
	  <form action="/board/qna/detail" method="get">
	    	<input type="hidden" name="qnaNo" value="${qnaNo}">
	    	<input type="password" name="qnaPassword" placeholder="비밀번호를 입력하세요" required>
	    	
	    	<button type="submit">확인</button>
	    	
	    	<c:if test="${not empty errorMsg}">
                <p class="error">${errorMsg}</p>
            </c:if>
	  </form>
	</div>
</body>
</html>
