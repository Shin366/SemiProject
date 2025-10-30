<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ForTrip - 자유게시판 글쓰기</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">
	<link rel="stylesheet" href="/resources/css/common/rset.css">
	<link rel="stylesheet" href="/resources/css/board/free/insert.css">
</head>
<body>
	<!-- header -->
   <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <h2>자유 게시판</h2>

        <form action="/board/free/insert" method="post" enctype="multipart/form-data">
            <div class="top-fields">
                <input type="text" name="postTitle" placeholder="제목을 입력해주세요..." required>
                <input type="text" name="writer" value="${loginMember.nickName}" readonly placeholder="작성자 닉네임">
            </div>

            <textarea name="postContent" placeholder="본문을 입력해주세요..." required></textarea>

            <div class="file-upload">
                <label>첨부 파일:</label>
                <input type="file" name="files">
            </div>

            <div class="buttons">
                <button type="button" class="btn btn-cancel" onclick="location.href='/board/free/list'">취소</button>
                <button type="submit" class="btn btn-submit">작성</button>
            </div>
        </form>
    </div>

	<!-- footer -->
   <%--  <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
</body>
</html>
