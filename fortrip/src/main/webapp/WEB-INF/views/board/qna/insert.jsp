<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>1:1 문의 작성 - 고객지원</title>
    <style>
        /* 1번 JSP와 공통 스타일 생략 */
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
        .btn-submit { background-color: #007bff; color: white; border: none; }
    </style>
</head>
<body>
    <div class="container">
         <aside class="sidebar">
            <a href="#">공지 사항</a>
            <a href="#">자주 묻는 질문</a>
            <a href="#" class="active">1:1 문의</a>
            <a href="#">신고 게시판</a>
        </aside>
        <main class="main-content">
            <h1 class="page-title">문의 게시판</h1>
            <form action="/qna/write" method="post" enctype="multipart/form-data">
                <div class="form-group title-group">
                    <input type="text" name="title" placeholder="제목을 입력해주세요....">
                    <span class="author">${sessionScope.loginUser.nickname}</span>
                </div>
                <div class="form-group content-group">
                    <textarea name="content" placeholder="내용을 입력해주세요..."></textarea>
                </div>
                <div class="form-group attachment-group">
                    <label>첨부 파일: </label>
                    <input type="file" name="attachment">
                </div>
                <div class="actions">
                    <button type="button" class="btn" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-submit">작성</button>
                </div>
            </form>
        </main>
    </div>
</body>
</html>