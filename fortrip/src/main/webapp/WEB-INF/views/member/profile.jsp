<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 내 프로필</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
</head>
<body>
	<div id="container">
        <main id="main">
        
            <div class="profile-section">
                <div class="profile-image"></div>
                <h2 class="profile-nickName">${member.nickName}</h2>
                <p class="profile-name">${member.memberName}</p>
                <p class="profile-memberId">${member.memberId}</p>
                <p class="enroll-date">${member.enrollDate}</p>
                
                <div class="like-list">
                    <h2 class="board">게시글</h2>
                    <h2 class="boardNo"></h2>
                    <h2 class="like">좋아요</h2>
                    <h2 class="likeNo"></h2>
                    <h2 class="myPick">찜</h2>
                    <h2 class="myPickNo"></h2>
                </div>
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
        </main>
    </div>
</body>
</html>