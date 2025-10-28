<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 최근 본 코스</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
</head>
<body>
	<div id="container">
        <main id="main">
            <div class="recent-container">
                <div class="recent-title">
                    <h2>최근 본 코스</h2>
                </div>
                <button onclick="edit">편집</button>
            </div>
            <div class="sidebar">
                <ul class="menu-list">
                    <li><a href="profile">내 프로필</a></li>
                    <li><a href="myBoard">내 게시글</a></li>
                    <li><a href="list">찜 목록</a></li>
                    <li><a href="recent">최근 본 코스</a></li>
                    <li><a href="update">개인 정보 수정</a></li>
                    <li><a href="delete">회원탈퇴</a></li>
                </ul>
            </div>
            <div class="mainbar">
                <div class="img"></div>
                <div class="tripdate">여행날짜</div>
                <div class="title">제목</div>
                <div class="price">가격</div>
            </div>
        </main>
    </div>
</body>
</html>