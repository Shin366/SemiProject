<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 내 게시글</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
</head>
<body>
	<div id="container">
        <main id="main">
            <div class="myboard-container">
                <div class="myboard-title">
                    <h2>내 게시글</h2>
                </div>
                <select name="type" id="type">
                    <option value="reviews">리뷰</option>
                    <option value="community">커뮤니티</option>
                </select>
            </div>
            <div class="sidebar">
                <ul class="menu-list">
                    <li><a href="profile">내 프로필</a></li>
                    <li><a href="myboard">내 게시글</a></li>
                    <li><a href="list">찜 목록</a></li>
                    <li><a href="recet">최근 본 코스</a></li>
                    <li><a href="update">개인 정보 수정</a></li>
                    <li><a href="delete">회원탈퇴</a></li>
                </ul>
            </div>
            <div class="mainbar">
                <div class="img"></div>
                <div class="type">타입</div>
                <div class="title">제목</div>
                <div class="update">
                    <a href="#">수정하기</a>
                </div>
                <div class="delete">
                    <a href="#">삭제하기</a>
                </div>
                <div class="date">업로드 날짜</div>
                <div class="heart">찜</div>
                <div class="comment">댓글</div>
                <div class="views">조회수</div>
            </div>
        </main>
    </div>
</body>
</html>