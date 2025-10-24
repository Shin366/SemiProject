<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>자유 게시판 글 수정</title>
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <style>
        body { font-family: sans-serif; background-color: #f8f9fa; margin: 0; }
        .container { display: flex; max-width: 1200px; margin: 20px auto; gap: 20px; }
        .sidebar { flex: 0 0 180px; }
        .sidebar a { display: block; padding: 12px 20px; text-decoration: none; color: #333; border-radius: 8px; font-weight: 500; }
        .sidebar a.active { background-color: #007bff; color: white; font-weight: bold; }
        .main-content { flex-grow: 1; background-color: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .page-title { font-size: 28px; font-weight: bold; margin-top: 0; margin-bottom: 30px; }
        form { display: flex; flex-direction: column; gap: 20px; }
        input[type="text"], textarea {
            width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px;
            font-size: 16px; box-sizing: border-box;
        }
        textarea { min-height: 250px; resize: vertical; line-height: 1.6; }
        .attachment-section { padding: 10px 0; font-size: 14px; border-top: 1px solid #eee; }
        .attachment-section a { margin-right: 10px; color: #007bff; text-decoration: none; }
        .attachment-section a:hover { text-decoration: underline; }
        .btn-group { text-align: right; margin-top: 30px; }
        .btn { padding: 10px 20px; border-radius: 6px; font-size: 15px; cursor: pointer; border: none; }
        .btn-submit { background-color: #007bff; color: white; }
        .btn-cancel { background-color: #e9ecef; color: #333; margin-left: 10px; }
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
