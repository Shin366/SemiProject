<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 개인 정보 수정</title>
<link rel="icon" type="image/png" href="">
</head>
<body>
	<div id="container">
        <main id="main">
            <div class="upDate-title">
                <h2>개인 정보 수정</h2>
            </div>
            <div class="profile-section">
                <div class="profile-image"></div>
                <h3 class="profile-name">이름</h3>
                <p class="profile-memberId">아이디</p>
                <p class="enroll-date">가입일</p>
            </div>
            <div class="sidebar">
                <ul class="menu-list">
                    <li><a href="#">내 프로필</a></li>
                    <li><a href="#">내 게시글</a></li>
                    <li><a href="#">찜 목록</a></li>
                    <li><a href="#">최근 본 코스</a></li>
                    <li><a href="#">개인 정보 수정</a></li>
                    <li><a href="#">회원탈퇴</a></li>
                </ul>
            </div>
            <div class="content-area">
                <form action="/member/upDate" method="post">
                    <div class="info-group">
                        <label for="">닉네임</label>
                        <input type="text" value="">
                    </div>
                    <div class="">
                        <label for="">휴대폰 번호</label>
                        <input type="text" value="">
                    </div>
                    <div class="">
                        <label for="">이메일</label>
                        <input type="text" value="">
                    </div>
                    <span class="pwUpdate-button">
                        <a href="">비밀번호 변경</a>
                    </span>
                </form>
                <button type="submit" class="update-button">수정하기</button>
            </div>
        </main>
    </div>
</body>
</html>