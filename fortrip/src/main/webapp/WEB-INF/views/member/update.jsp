<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 개인 정보 수정</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="/resources/css/member/update.css">
</head>
<body>
	<div class="container">
        <!-- ✅ 사이드바 (list.css 스타일 통일) -->
        <aside class="sidebar">
            <a href="profile">내 프로필</a>
            <a href="myBoard">내 게시글</a>
            <a href="list">찜 목록</a>
            <a href="recent">최근 본 코스</a>
            <a href="update" class="active">개인 정보 수정</a>
            <a href="delete">회원 탈퇴</a>
        </aside>

        <!-- ✅ 메인 콘텐츠 -->
        <main class="main-content">
            <div class="header-section">
                <h2 class="page-title">개인 정보 수정</h2>
            </div>

            <div class="profile-section">
                <div class="profile-image"></div>
                <h3 class="profile-name">${member.name}</h3>
                <p class="profile-memberId">${member.memberId}</p>
                <p class="enroll-date">가입일: ${member.enrollDate}</p>
            </div>

            <form action="/member/update" method="post" class="update-form">
                <div class="info-group">
                    <label for="nickName">닉네임</label>
                    <input type="text" name="nickName" value="${member.nickName}">
                </div>

                <div class="info-group">
                    <label for="phone">휴대폰 번호</label>
                    <input type="text" name="phone" value="${member.phone}">
                </div>

                <div class="info-group">
                    <label for="email">이메일</label>
                    <input type="text" name="email" value="${member.email}">
                </div>

                <div class="info-group">
                    <label for="tendency">여행 성향</label>
                    <select name="tendency" id="tendency">
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

                <div class="button-group">
                    <a href="/member/pwUpdate" class="btn-secondary">비밀번호 변경</a>
                    <button type="submit" class="btn-primary">수정하기</button>
                </div>
            </form>
        </main>
    </div>
</body>
</html>
