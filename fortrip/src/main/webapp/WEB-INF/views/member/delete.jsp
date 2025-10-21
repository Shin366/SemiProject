<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 회원탈퇴</title>
<link rel="icon" type="image/png" href="">
</head>
<body>
	<div id="container">
        <main id="main">
            <div class="delete-container">
                <div class="delete-title">
                    <h2>회원탈퇴</h2>                
                </div>
                <div class="delete-title2">
                    <p class="">회원탈퇴 유의사항</p>
                    <p class="">회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</p>
                </div>
                <div class="">
                    <li class="">
                        ⦁ 사용하고 계신 아이디는 탈퇴할 경우 재사용 및 복구가 불가능합니다.
                    </li>
                    <p class="">
                        탈퇴한 아이디는 본인과 타인 모두 재사용 및 복구가 불가하오니 신중하게 선택하시길 바랍니다.
                    </p>
                </div>
                <div class="">
                    <li class="">
                        ⦁ 탈퇴 후 회원정보 및 서비스 이용기록은 모두 삭제됩니다.
                    </li>
                    <p class="">
                        회원정보 및  게시글, 개인 서비스 이용기록은 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다. <br>
                        필요한 데이터의 경우 미리 백업을 해주세요.
                    </p>
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
                <div class="delete-title3">
                    <p class="">비밀번호 확인</p>
                    <p class="">회원탈퇴를 신청하기 전 비밀번호를 입력해주세요.</p>
                </div>
                <form class="delete-form" action="/member/delete" method="post">
                    <div class="form-group">
                        <label for="">이름</label>
                        <input type="text" name="memberName">
                    </div>
                    <div class="form-group">
                        <label for="">아이디</label>
                        <input type="text" name="memberId">
                    </div>
                    <div class="form-group">
                        <label for="">비밀번호</label>
                        <input type="password" name="memberPw">
                    </div>
                    <button type="submit">탈퇴하기</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>