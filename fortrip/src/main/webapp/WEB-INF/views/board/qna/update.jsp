<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 수정 - 고객지원</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">
	<link rel="stylesheet" href="/resources/css/board/qna/update.css">
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
