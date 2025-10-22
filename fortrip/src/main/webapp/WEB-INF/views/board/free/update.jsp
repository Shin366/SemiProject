<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${post.title} - 자유 게시판</title> <%-- 실제 데이터 연동 예시 --%>
    <style>
        body { font-family: sans-serif; background-color: #f8f9fa; margin: 0; }
        .container { display: flex; max-width: 1200px; margin: 20px auto; gap: 20px; }
        .sidebar { flex: 0 0 180px; }
        .sidebar a { display: block; padding: 12px 20px; text-decoration: none; color: #333; border-radius: 8px; font-weight: 500; }
        .sidebar a.active { background-color: #007bff; color: white; font-weight: bold; }
        .main-content { flex-grow: 1; background-color: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .page-title { font-size: 28px; font-weight: bold; margin-top: 0; margin-bottom: 30px; }
        .post-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #333; padding-bottom: 15px; }
        .post-title { font-size: 24px; margin: 0; }
        .post-category { background-color: #e9ecef; padding: 5px 10px; border-radius: 15px; font-size: 14px; }
        .post-body { padding: 30px 0; min-height: 300px; font-size: 16px; line-height: 1.8; border-bottom: 1px solid #dee2e6;}
        .attachment-section { padding: 20px 0; font-size: 14px; }
        .actions { text-align: right; margin-top: 20px; }
        .btn { padding: 8px 18px; border-radius: 6px; text-decoration: none; font-size: 14px; margin-left: 8px; border: 1px solid #ccc; background-color: #fff; cursor: pointer; }
        .btn-edit { border-color: #007bff; color: #007bff; }
        .btn-delete { border-color: #dc3545; color: #dc3545; }
        .bottom-actions { display: flex; justify-content: flex-end; margin-top: 40px; }
        .btn-list { background-color: #007bff; color: white; border: none; padding: 12px 25px; }
    </style>
</head>
<body>
    <%-- 헤더 영역 --%>
    <%-- <jsp:include page="/WEB-INF/views/common/header.jsp" /> --%>

    <div class="container">
        <aside class="sidebar">
            <a href="#" class="active">자유 소통</a>
            <a href="#">코스 리뷰</a>
        </aside>

        <main class="main-content">
            <h1 class="page-title">자유 게시판</h1>

            <div class="post-container">
                <div class="post-header">
                    <h2 class="post-title">${post.title}</h2>
                    <span class="post-writer">${post.writer}</span>
                </div>

                <div class="post-body">
                    <p>${post.content}</p>
                </div>

                <div class="attachment-section">
                    <strong>첨부 파일 :</strong>
                    <%-- 첨부파일 목록이 있다면 반복문으로 표시 --%>
                    <c:forEach var="file" items="${post.attachments}">
                        <a href="${file.downloadPath}">${file.originalName}</a>
                    </c:forEach>
                    <c:if test="${empty post.attachments}">
                        <span>첨부파일이 없습니다.</span>
                    </c:if>
                </div>

                <div class="actions">
                    <%-- 로그인한 사용자와 게시글 작성자가 동일할 경우에만 수정/삭제 버튼 노출 --%>
                    <c:if test="${sessionScope.loginUser.memberNo == post.memberNo}">
                    <button type="button" class="btn btn-edit" onclick="location.href='/community/edit?no=${post.postNo}'">수정</button>
                        <button type="button" class="btn btn-delete" onclick="confirmDelete()">삭제</button>
                    </c:if>
                    <button type="button" class="btn" onclick="location.href='/community/list'">취소</button>
                </div>
            </div>

            <div class="bottom-actions">
                <a href="/community/list" class="btn btn-list">게시글 목록</a>
            </div>
        </main>
    </div>
</body>
</html>