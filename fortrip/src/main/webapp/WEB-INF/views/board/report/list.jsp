<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 게시판 - 고객지원</title>
    <style>
        /* 이전 페이지들과 공통된 스타일은 재사용합니다. */
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
        
        .report-list { list-style: none; padding: 0; margin: 0; border-top: 2px solid #333; }
        .list-item { display: flex; align-items: center; padding: 15px; border-bottom: 1px solid #dee2e6; }
        .item-no { width: 50px; text-align: center; color: #888; }
        .item-title a { text-decoration: none; color: #333; }
        
        /* 공지사항 스타일 */
        .list-item.notice { background-color: #f8f9fa; font-weight: bold; }
        .notice-tag { display: inline-block; background-color: #dc3545; color: white; font-size: 12px; padding: 3px 8px; border-radius: 4px; margin-right: 10px; }

        .actions { text-align: right; margin-top: 20px; }
        .btn-write { background-color: #007bff; color: white; border: none; padding: 10px 24px; text-decoration: none; border-radius: 6px; }
        
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 40px; }
        .pagination a, .pagination strong { display: inline-block; width: 32px; height: 32px; line-height: 32px; text-align: center; border-radius: 4px; text-decoration: none; color: #333; }
        .pagination a:hover { background-color: #e9ecef; }
        .pagination strong { background-color: #007bff; color: white; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <a href="#">공지 사항</a>
            <a href="#">자주 묻는 질문</a>
            <a href="#">1:1 문의</a>
            <a href="#" class="active">신고 게시판</a>
        </aside>

        <main class="main-content">
            <h1 class="page-title">신고 게시판</h1>
            <div class="list-header">
                <form action="/report/list" class="search-form">
                    <select name="condition">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                    <input type="text" name="keyword" placeholder="검색어를 입력해주세요">
                    <button type="submit">검색</button>
                </form>
            </div>

            <ul class="report-list">
                <%-- Controller에서 고정 공지(pinnedNotice) 객체를 전달받았을 경우에만 표시 --%>
                <c:if test="${not empty pinnedNotice}">
                    <li class="list-item notice">
                        <div class="item-no"><span class="notice-tag">공지</span></div>
                        <div class="item-title">
                            <a href="/notice/detail?no=${pinnedNotice.noticeNo}">${pinnedNotice.title}</a>
                        </div>
                    </li>
                </c:if>

                <%-- Controller에서 전달받은 신고 목록(reportList)을 반복문으로 출력 --%>
                <c:forEach var="report" items="${reportList}">
                    <li class="list-item">
                        <div class="item-no">${report.reportNo}</div>
                        <div class="item-title">
                            <a href="/report/detail?no=${report.reportNo}">${report.title}</a>
                        </div>
                    </li>
                </c:forEach>
            </ul>

            <div class="actions">
                <a href="/report/write" class="btn-write">게시글 작성</a>
            </div>

            <nav class="pagination">
                <a href="#">&lt;</a>
                <strong>1</strong>
                <a href="#">2</a>
                <a href="#">...</a>
                <a href="#">9</a>
                <a href="#">10</a>
                <a href="#">&gt;</a>
            </nav>
        </main>
    </div>
</body>
</html>