<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 목록</title>
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
        
        .list-header { display: flex; justify-content: flex-end; margin-bottom: 20px; }
        .search-form { display: flex; gap: 5px; }
        .search-form select, .search-form input { padding: 8px; border: 1px solid #ccc; border-radius: 4px; }
        
        .notice-list { list-style: none; padding: 0; margin: 0; }
        .notice-item { display: flex; justify-content: space-between; padding: 15px; border: 1px solid #dee2e6; border-radius: 8px; margin-bottom: 10px; }
        .notice-item a { text-decoration: none; color: #333; font-weight: 500; }
        .notice-item .author { color: #888; }

        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 40px; }
        .pagination a, .pagination strong { display: inline-block; width: 32px; height: 32px; line-height: 32px; text-align: center; border-radius: 4px; text-decoration: none; color: #333; }
        .pagination a:hover { background-color: #e9ecef; }
        .pagination strong { background-color: #007bff; color: white; font-weight: bold; }
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
            <div class="list-header">
                <form action="/board/notice/list" class="search-form">
                    <select name="condition">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                    <input type="text" name="keyword" placeholder="검색어를 입력해주세요">
                    <button type="submit">검색</button>
                </form>
            </div>

            <ul class="notice-list">
                <c:forEach var="notice" items="${nList}">
                    <li class="notice-item">
                        <a href="/board/notice/detail?noticeNo=${notice.noticeNo}">${notice.noticeTitle}</a>
                        <span class="author">관리자</span>
                    </li>
                </c:forEach>
            </ul>

            <nav class="pagination">
                <c:if test="${startNavi ne 1 }">
                    <a href="/board/notice/list?page=${startNavi - 1 }" class="prev">&laquo; 이전</a>
               	</c:if>
                    <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                      <a href="/board/notice/list?page=${n }" class='page-number <c:if test="${currentPage eq n }">active</c:if>'>${n }</a>
                    </c:forEach>
                    <c:if test="${endNavi ne maxPage }">
                      <a href="/board/notice/list?page=${endNavi + 1 }" class="next">다음 &raquo;</a>
                    </c:if>
            </nav>
        </main>
    </div>
</body>
</html>