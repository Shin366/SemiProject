<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">
	<link rel="stylesheet" href="/resources/css/board/notice/detail.css">
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