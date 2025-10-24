<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forTrip - 질문관리</title>
<link href="../resources/admin/img/eyes-icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="../resources/admin/css/questionSet.css">
</head>
<body>
	<div id="container">
	    <jsp:include page="/WEB-INF/views/admin/include/header.jsp"/>
		<c:if test ="${not empty success }">
			<script>
				alert("${success}");
			</script>
		</c:if>
		<c:if test ="${not empty error }">
			<script>
				alert("${error}");
			</script>
		</c:if>
        <div id="main">
            <div id="question-wrapper">
                <h1>자주하는 질문 관리</h1>
                <form action="/question/insert" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="question-title">질문 제목</label>
                            <input type="text" name="questionTitle" id="question-title" placeholder="질문 제목을 입력하세요" required>
                        </div>
                        <div class="form-group">
                            <label for="questionCategory">질문 카테고리</label>
                            <select name="questionCategory" id="questionCategory">
                                <option value=" " selected disabled hidden>카테고리</option>
                                <option value="여행관련">여행 관련</option>
                                <option value="회원관련">회원 관련</option>
                                <option value="커뮤니티&고객센터">커뮤니티 & 고객센터</option>
                                <option value="찜하기및리뷰">찜하기 및 리뷰</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="question-content">질문 답변</label>
                        <textarea id="question-content" name="questionContent" rows="10" placeholder="질문 답변을 작성해주세요" required></textarea>
                    </div>

                    <div class="btn-row">
                        <button type="submit" id="question-save-btn">등록하기</button>
                        <button type="button" id="question-cancel-btn">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>