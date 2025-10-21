<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 비밀번호 변경</title>
<link rel="icon" type="image/png" href="">
</head>
<body>
	<div id="container">
        <main id="">
            <div class="pwUpDate-container">
                <div class="pwUpDate-title">
                    <h2>비밀 번호 변경</h2>
                </div>
                <form class="pwUpDate-form" action="/member/pwUpDate" method="post">
                    <div class="form-group">
                        <label for="">기존 비밀번호</label>
                        <input type="password" name="memberPw" placeholder="기존 비밀번호를 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label for="">새 비밀번호</label>
                        <input type="password" name="newMemberPw" placeholder="새 비밀번호를 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label for="">새 비밀번호 확인</label>
                        <input type="password" name="newMemberPwd" placeholder="새 비밀번호를 다시 입력해주세요." required>
                    </div>
                    <button type="submit">변경하기</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>