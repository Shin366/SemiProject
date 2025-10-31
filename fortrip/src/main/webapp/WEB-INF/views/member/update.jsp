<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 개인 정보 수정</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
</head>
<body>
	<div id="container">
        <main id="main">
            <div class="update-title">
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
                    <li><a href="profile">내 프로필</a></li>
                    <li><a href="myBoard">내 게시글</a></li>
                    <li><a href="list">찜 목록</a></li>
                    <li><a href="recent">최근 본 코스</a></li>
                    <li><a href="update">개인 정보 수정</a></li>
                    <li><a href="delete">회원탈퇴</a></li>
                </ul>
            </div>
            <div class="content-area">
                <form action="/member/update" method="post">
                    <div class="info-group">
                        <label for="nickName">닉네임</label>
                        <input type="text" name="nickName" value="${member.nickName}">
                    </div>
                    <div class="newPhone">
                        <label for="phone">휴대폰 번호</label>
                        <input type="text" name="phone" value="${member.phone}">
                    </div>
                    <div class="newEmail">
                        <label for="">이메일</label>
                        <input type="text" name="email" value="${member.email}">
                    </div>
                    <div class="use-type">
                        <p>성향</p>
                        <select name="tendency" id="type">
                            <option value="N" ${member.tendency == 'N' ? 'selected' : ''}>성향 선택</option>
                            <option value="healing" ${member.tendency == 'healing' ? 'selected' : ''}>🌿 힐링러 (자연·휴식형)</option>
                            <option value="delicacies" ${member.tendency == 'delicacies' ? 'selected' : ''}>🍜 미식러 (맛집·로컬 중심)</option>
                            <option value="exploration" ${member.tendency == 'exploration' ? 'selected' : ''}>🧭 탐험러 (액티비티·모험형)</option>
                            <option value="emotion" ${member.tendency == 'emotion' ? 'selected' : ''}>🎨 감성러 (사진·문화·감성 중심)</option>
                            <option value="efficiency" ${member.tendency == 'efficiency' ? 'selected' : ''}>💼 실속러 (효율·가성비 중심)</option>
                            <option value="plan" ${member.tendency == 'plan' ? 'selected' : ''}>🧳 플래너형 (계획적·조직형)</option>
                            <option value="free" ${member.tendency == 'free' ? 'selected' : ''}>🎒 즉흥러 (자유·즉흥형)</option>
                        </select>
                    </div>
                    <span class="pwUpdate-button">
                        <a href="/member/pwUpdate">비밀번호 변경</a>
                    </span>
                <button type="submit" class="save-button">수정하기</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>