<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 찜 목록</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
</head>
<body>
	<div id="container">
        <main id="main">
            <div class="list-container">
                <div class="list-title">
                    <h2>찜 목록</h2>
                </div>
                <button onclick="edit">편집</button>
                <select name="seach" id="seach">
                    <option value="">지역조회</option>
                    <option value=""></option>
                </select>
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
                <div class="main-hi">
                    <div class="title">제목</div>
                    <div class="title">코스</div>
                </div>
                <div class="main-mi">
                    <div class="location">위치</div>
                    <div class="time">코스 시간</div>
                    <div class="score">별점</div>
                </div>
                <div class="main-lo">
                    <div class="date">등록일</div>
                    <div class="price">가격</div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>