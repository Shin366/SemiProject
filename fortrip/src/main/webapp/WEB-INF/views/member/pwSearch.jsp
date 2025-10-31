<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 비밀번호 찾기</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="/resources/css/member/pwSearch.css">
</head>
<body>
	<div id="container">
        <main id="main">
            <div id="pwSearch-container">
                <div class="pwSearch-title">
                    <h2>비밀번호 찾기</h2>
                </div>
                <form class="pwSearch-form" action="/member/pwSearch" method="post">
                    <div class="form-group">
                        <label class="required" for="memberId">아이디</label>
                        <input type="text" id="memberId" name="memberId" placeholder="아이디를 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label class="required" for="email">이메일</label>
                        <input type="text" id="email" name="email" placeholder="이메일을 입력해주세요." required>
                    </div>
                    <button type="submit">확인</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>