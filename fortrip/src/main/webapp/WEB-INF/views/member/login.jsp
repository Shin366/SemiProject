<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 로그인</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
<link rel="stylesheet" href="../resources/css/common/header.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="container">
        <main id="main">
            <div class="login-container">
                <div class="login-title">
                    <h2>로그인</h2>
                </div>
                <form class="login-form" action="/member/login" method="post">
                <input type="hidden" name="beforeURL" value="">
                    <div class="form-group">
                        <label class="required" for="memberId">아이디</label>
                        <input type="text" name="memberId" placeholder="아이디를 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label class="required" for="memberPw">비밀번호</label>
                        <input type="password" name="memberPw" placeholder="비밀번호를 입력해주세요." required>
                    </div>
                    <button type="submit">로그인</button>
                </form>
                <div class="login-links">
                    <a href="/member/idSearch">아이디 찾기</a>
                    <a href="/member/pwSearch">비밀번호 찾기</a>
                    <a href="/member/use">회원가입</a>
                </div>
            </div>
        </main>
    </div>
    <script>
    		window.onload = () => {
    			document.getElementsByName('beforeURL')[0].value = document.referrer;
    		}
    </script>
</body>

</html>