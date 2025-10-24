<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 수정 - 고객지원</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">
    <style>
        body { font-family: sans-serif; background-color: #f8f9fa; margin: 0; }
        .container { display: flex; max-width: 1200px; margin: 20px auto; gap: 20px; }
        .sidebar { flex: 0 0 180px; }
        .sidebar a { display: block; padding: 12px 20px; text-decoration: none; color: #333; border-radius: 8px; font-weight: 500; }
        .sidebar a.active { background-color: #007bff; color: white; font-weight: bold; }
        .main-content { flex-grow: 1; background-color: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .page-title { font-size: 28px; font-weight: bold; margin-top: 0; margin-bottom: 30px; }

        .form-group { margin-bottom: 20px; }
        .title-group { display: flex; border-bottom: 2px solid #333; }
        .title-group input { flex-grow: 1; border:none; padding: 15px 0; font-size: 20px; }
        .title-group input:focus { outline: none; }
        .title-group .author { padding: 15px; color: #888; }
        .content-group textarea { width: 100%; min-height: 300px; border: none; resize: vertical; padding: 20px 0; font-size: 16px; }
        .content-group textarea:focus { outline: none; }
        .attachment-group { border-top: 1px solid #dee2e6; padding-top: 20px; }
        .actions { text-align: right; margin-top: 20px; }
        .btn { padding: 10px 24px; border-radius: 6px; text-decoration: none; font-size: 15px; margin-left: 8px; border: 1px solid #ccc; background-color: #fff; cursor: pointer; }
        .btn-update { background-color: #007bff; color: white; border: none; }
        .btn-delete { background-color: #dc3545; color: white; border: none; }
        .bottom-actions { display: flex; justify-content: flex-end; margin-top: 40px; }
        .btn-list { background-color: #007bff; color: white; border: none; padding: 10px 24px; text-decoration: none; border-radius: 6px; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="container">
         <aside class="sidebar">
            <a href="/board/notice/list">공지 사항</a>
            <a href="/board/faq/list">자주 묻는 질문</a>
            <a href="/board/qna/list" class="active">1:1 문의</a>
            <a href="/board/report/list">신고 게시판</a>
        </aside>
        <main class="main-content">
            <h1 class="page-title">문의 수정</h1>

            <form id="editForm" action="/board/qna/update" method="post" enctype="multipart/form-data">
                <input type="hidden" name="qnaNo" value="${boardQna.qnaNo}">

                <div class="form-group title-group">
                    <input type="text" name="qnaTitle" value="${boardQna.qnaTitle}">
                    <span class="author">${sessionScope.loginUser.nickName}</span>
                </div>

                <div class="form-group content-group">
                    <textarea name="qnaContent">${boardQna.qnaContent}</textarea>
                </div>

                <!-- 첨부파일 영역 -->
                <div class="attachment-section">
                    <strong>첨부파일:</strong><br>
                    <c:forEach var="file" items="${attachments}">
                        <label>
                            <input type="checkbox" name="deletedFiles" value="${file.fileNo}"> 
                            <a href="${file.downloadPath}" target="_blank">${file.originalName}</a>
                        </label><br>
                    </c:forEach>
                    <br>
                    <label>새 파일 추가:</label>
                    <input type="file" name="reloadFiles" multiple>
                </div>

                <div class="actions">
                    <button type="button" class="btn" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-update">수정 완료</button>
                    <button type="button" id="deleteBtn" class="btn btn-delete"
                            onclick="location.href='/board/qna/delete?qnaNo=${boardQna.qnaNo}'">삭제</button>
                </div>
            </form>

            <div class="bottom-actions">
                <a href="/board/qna/list" class="btn-list">게시글 목록</a>
            </div>
        </main>
    </div>
</body>
</html>
