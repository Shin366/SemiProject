<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
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
        
        .post-header { border-bottom: 2px solid #333; padding-bottom: 15px; }
        .post-title { font-size: 24px; margin: 0; }
        .post-body { padding: 30px 0; min-height: 250px; font-size: 16px; line-height: 1.8; border-bottom: 1px solid #dee2e6;}
        .post-nav { list-style: none; padding: 0; margin: 0; border-bottom: 1px solid #dee2e6; }
        .post-nav li { display: flex; padding: 15px 5px; border-top: 1px solid #f1f1f1; }
        .post-nav .nav-label { font-weight: bold; width: 80px; }
        .post-nav .nav-title a { text-decoration: none; color: #555; }
        .bottom-actions { text-align: right; margin-top: 20px; }
        .btn-list { background-color: #007bff; color: white; border: none; padding: 10px 24px; text-decoration: none; border-radius: 6px; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="container">
        <aside class="sidebar">
            <a href="/board/notice/list" class="active">공지 사항</a>
            <a href="/board/faq/list">자주 묻는 질문</a>
            <a href="/board/qna/list">1:1 문의</a>
            <a href="/board/report/list">신고 게시판</a>
        </aside>
        <main class="main-content">
            <h1 class="page-title">공지 사항</h1>
            <div class="post-header">
                <h2 class="post-title">${detail.notice.noticeTitle}</h2>
            </div>
            <div class="post-body">
                <p>${detail.notice.noticeContent}</p>
            </div>
            <ul class="post-nav">
                <li>
                    <span class="nav-label">이전글</span>
                    <span class="nav-title"><a href="/board/notice/detail?noticeNo=${detail.prevNotice.noticeNo}">${detail.prevNotice.noticeTitle}</a></span>
                </li>
                <li>
                    <span class="nav-label">다음글</span>
                    <span class="nav-title"><a href="/board/notice/detail?noticeNo=${detail.nextNotice.noticeNo}">${detail.nextNotice.noticeTitle}</a></span>
                </li>
            </ul>
            <div class="bottom-actions">
                <a href="/board/notice/list" class="btn-list">목록</a>
            </div>
        </main>
    </div>
</body>
</html>