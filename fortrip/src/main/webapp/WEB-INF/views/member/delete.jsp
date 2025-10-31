<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 회원탈퇴</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="/resources/css/member/delete.css">
</head>
<body>
    <div id="container">
        <main id="main">
            
            <!-- 사이드바 -->
            <div class="sidebar">
                <ul class="menu-list">
                    <li><a href="profile">내 프로필</a></li>
                    <li><a href="myBoard">내 게시글</a></li>
                    <li><a href="list">찜 목록</a></li>
                    <li><a href="recent">최근 본 코스</a></li>
                    <li><a href="update">개인 정보 수정</a></li>
                    <li><a href="delete" class="active">회원탈퇴</a></li>
                </ul>
            </div>

            <!-- 회원탈퇴 내용 -->
            <div class="delete-container">
                <h2 class="delete-title">회원탈퇴</h2>                

                <div class="delete-warning">
                    <p class="warning-title">회원탈퇴 유의사항</p>
                    <ul class="warning-list">
                        <li>사용하고 계신 아이디는 탈퇴할 경우 재사용 및 복구가 불가능합니다.</li>
                        <li>탈퇴 후 회원정보 및 서비스 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.</li>
                    </ul>
                </div>

                <div class="delete-password">
                    <p>회원탈퇴를 신청하기 전 비밀번호를 입력해주세요.</p>
                    <form class="delete-form" action="/member/delete" method="post">
                        <div class="form-group">
                            <label for="memberName">이름</label>
                            <input type="text" name="memberName" value="<c:out value='${member.memberName}'/>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="memberId">아이디</label>
                            <input type="text" name="memberId" value="<c:out value='${member.memberId}'/>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="memberPw">비밀번호</label>
                            <input type="password" name="memberPw" required>
                        </div>
                        <button type="submit" class="btn-delete">탈퇴하기</button>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
