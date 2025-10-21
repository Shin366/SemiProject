<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 비밀번호 찾기</title>
<link rel="icon" type="image/png" href="">
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
                        <label for="">아이디</label>
                        <input type="text" name="memberid" placeholder="아이디를 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label for="">이메일</label>
                        <input type="text" name="email" placeholder="이메일을 입력해주세요." required>
                    </div>
                    <button type="submit">확인</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>