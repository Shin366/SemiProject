<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 회원가입</title>
<link rel="icon" type="image/png" href="">
</head>
<body>
	<div id="signup-container">
        <div class="singup-title">
            <h2>회원가입</h2>
        </div>
        <form action="/member/signup" class="signup-form" method="post">
            <div class="form-group">
                <label class="required" for="memberId">아이디</label>
                <input type="text" id="memberId" name="memberId" placeholder="아이디를 입력해주세요." required>
            </div>
            <div class="form-group">
                <label class="required" for="memberPw">비밀번호</label>
                <input type="text" id="memberPw" name="memberPw" placeholder="비밀번호를 입력해주세요." required>
            </div>
            <div class="form-group">
                <label class="required" for="memberName">이름</label>
                <input type="text" id="memberName" name="memberName" placeholder="이름을 입력해주세요." required>
            </div>
            <div class="form-group">
                <label class="required" for="nickName">닉네임</label>
                <input type="text" id="nickName" name="nickName" placeholder="닉네임을 입력해주세요.">
            </div>
            <div class="form-group">
                <label class="required" for="phone">전화번호</label>
                <input type="text" id="phone" name="phone" placeholder="전화번호를 입력해주세요.">
            </div>
            <div class="form-group">
                <label class="required" for="birthDate">생년월일</label>
                    <div class="birthdate-group">
						<input type="text" name="birthDateYear" id="birthDateYear" placeholder="YYYY" required><span>년</span>
						<input type="text" name="birthDateMon" id="birthDateMon" placeholder="MM" required><span>월</span>
						<input type="text" name="birthDateDay" id="birthDateDay" placeholder="DD" required><span>일</span>
					</div>
            </div>
            <div class="form-group">
                <label class="required" for="email">이메일</label>
                <input type="email" id="email" name="email" placeholder="이메일을 입력해주세요.">
            </div>
            <div class="form-group">
                <label class="required" for="gender">성별</label>
                <label><input type="radio" name="gender" value="M" checked>남</label>
                <label><input type="radio" name="gender" value="F">여</label>
            </div>
            <button type="submit" class="signup-button">가입</button>
        </form>
    </div>
</body>
</html>