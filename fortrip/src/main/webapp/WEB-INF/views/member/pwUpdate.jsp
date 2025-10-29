<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 비밀번호 변경</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
</head>
<body>
	<div id="container">
        <main id="main">
            <div class="pwUpdate-container">
                <div class="pwUpdate-title">
                    <h2>비밀 번호 변경</h2>
                </div>
                <form class="pwUpdate-form" action="/member/pwUpdate" method="post">
                    <div class="form-group">
                        <label class="required" for="currentPw">기존 비밀번호</label>
                        <input type="password" name="currentPw" placeholder="기존 비밀번호를 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label class="required" for="newPw">새 비밀번호</label>
                        <input type="password" name="newPw" placeholder="새 비밀번호를 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label class="required" for="confirmPw">새 비밀번호 확인</label>
                        <input type="password" name="confirmPw" placeholder="새 비밀번호를 다시 입력해주세요." required>
                    </div>
                    <button type="submit">변경하기</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>