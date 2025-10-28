<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forTrip - 회원추가</title>
<link href="../../../resources/img/common/eyes-icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="../../../resources/css/admin/userSet.css">
</head>
<body>
	<div id="container">
		<jsp:include page="/WEB-INF/views/admin/include/header.jsp"/>
		<c:if test ="${ not empty success }">
			<script>
				alert("${success}")
			</script>
		</c:if>
		<c:if test ="${ not empty error }">
			<script>
				alert("${error}")
			</script>
		</c:if>
		<div id="main">
	        <div class="userAdd-wrapper">
				<h1>회원 수정</h1>
				<form action="/admin/user/modify" method="post">
				<input type="hidden" name="memberNo" value="${memberInfo.memberNo }">
					<div class="form-row">
						<div class="form-group">
							<label for="memberName">이름</label>
							<input type="text" name="memberName" id="memberName" value="${memberInfo.memberName }" placeholder="이름을 입력해주세요"required>
						</div>
						<div class="form-group">
							<label for="nickname">닉네임</label>
							<input type="text" name="nickName" id="nickname" value="${memberInfo.nickName }" placeholder="닉네임을 입력해주세요" required>
						</div>
					</div>

					<div class="form-row">
						<div class="form-group">
							<label for="memberId">아이디</label>
							<input type="text" name="memberId" id="memberId" value="${memberInfo.memberId }" placeholder="아이디를 입력해주세요" required>
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group">
							<label for="memberPw">비밀번호</label>
							<input type="password" name="memberPw" id="memberPw" value="${memberInfo.memberPw }" placeholder="비밀번호를 입력해주세요" autocomplete="current-password" required>
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group">
							<label for="phone">전화번호</label>
							<input type="text" name="phone" id="phone" value="${memberInfo.phone }" placeholder="전화번호를 입력해주세요" required>
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group">
							<label for="email">이메일</label>
							<input type="email" name="email" id="email" value="${memberInfo.email }" placeholder="이메일을 입력해주세요" required>
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group">
							<label for="birthDateYear">생년월일</label>
							<div class="birthdate-group">
								<input type="text" name="birthDateYear" id="birthDateYear" value="${memberInfo.birthDateYear }" placeholder="YYYY" required><span>년</span>
								<input type="text" name="birthDateMon" id="birthDateMon" value="${memberInfo.birthDateMon }" placeholder="MM" required><span>월</span>
								<input type="text" name="birthDateDay" id="birthDateDay" value="${memberInfo.birthDateDay }" placeholder="DD" required><span>일</span>
							</div>
						</div>
					</div>

					<div class="form-row">
						<div class="form-group">
							<label>등급</label>
							<div class="radio-group">
								<label><input type="radio" name="adminYn" value="Y"> 관리자</label>
								<label><input type="radio" name="adminYn" value="N" checked> 일반회원</label>
							</div>
						</div>
					</div>
					
					<div class="form-row">
						<div class="form-group">
							<label>상태</label>
							<div class="radio-group">
								<label><input type="radio" name="statusYsn" value="Y" checked>활성</label>
								<label><input type="radio" name="statusYsn" value="N" >비활성</label>
								<label><input type="radio" name="statusYsn" value="S" >정지</label>
							</div>
						</div>
					</div>
					<div class="btn-row">
						<button type="submit" id="user-save-btn">저장</button>
						<button type="button" id="user-cancel-btn">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>