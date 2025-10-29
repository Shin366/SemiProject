<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자유 게시판 글 수정</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/board/free/update.css">
    <style>
        
    </style>
</head>
<body>
    <%-- 공통 헤더 --%>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <aside class="sidebar">
            <a href="/board/free/list" class="active">자유 소통</a>
            <a href="/board/review/list">코스 리뷰</a>
        </aside>

        <main class="main-content">
            <h1 class="page-title">자유게시판 게시글 수정</h1>

            <form action="<c:url value='/board/free/update'/>" method="post" enctype="multipart/form-data">
                <input type="hidden" name="postNo" value="${free.postNo}">

                <label>제목</label>
                <input type="text" name="postTitle" value="${free.postTitle}" required>

				<!-- 본문 내용 -->
                <label>내용</label>
                <textarea name="postContent" required>${free.postContent}</textarea>

				<!-- 첨부파일 영역 -->	
                <div class="attachment-section">
                    <strong>첨부파일:</strong><br>
                    <c:forEach var="file" items="${post.attachments}">
                        <label>
                            <input type="checkbox" name="deletedFiles" value="${file.fileNo}"> 
                            <a href="${file.downloadPath}" target="_blank">${file.originalName}</a>
                        </label><br>
                    </c:forEach>
                    <br>
                    <label>새 파일 추가:</label>
                    <input type="file" name="reloadFiles" multiple>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-submit">수정 완료</button>
                    <button type="button" class="btn btn-cancel" onclick="location.href='<c:url value='/board/free/detail?postNo=${free.postNo}'/>'">취소</button>
                </div>
            </form>
        </main>
    </div>
</body>
</html>
