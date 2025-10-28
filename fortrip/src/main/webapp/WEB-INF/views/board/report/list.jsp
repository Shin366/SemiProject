<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 게시판 - 고객지원</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="<c:url value='/resources/css/common/header.css'/>"> 
    <style>
        /* --- 기본 & 레이아웃 --- */
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; background-color: #f8f9fa; margin: 0; color: #343a40; }
        .container { display: flex; max-width: 1200px; margin: 30px auto; gap: 30px; }
        .sidebar { flex: 0 0 200px; }
        .main-content { flex-grow: 1; background-color: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }

        /* --- 사이드바 --- */
        .sidebar ul { list-style: none; padding: 0; background-color: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); padding: 10px; }
        .sidebar a { display: block; padding: 15px 20px; text-decoration: none; color: #555; border-radius: 6px; font-weight: 600; font-size: 16px; }
        .sidebar a.active, .sidebar a:hover { background-color: #007bff; color: white; }

        /* --- 메인 컨텐츠 --- */
        .page-title { font-size: 28px; font-weight: bold; margin-top: 0; margin-bottom: 30px; }
        .list-header { display: flex; justify-content: flex-end; margin-bottom: 20px; }
        .search-form { display: flex; gap: 5px; }
        .search-form select, .search-form input, .search-form button { padding: 8px; border: 1px solid #ccc; border-radius: 4px; font-size: 14px; }
        .search-form button { background-color: #6c757d; color: white; border-color: #6c757d; cursor: pointer;}

        /* --- 목록 스타일 --- */
        .report-list { list-style: none; padding: 0; margin: 0; border-top: 2px solid #333; }
        .list-item { display: grid; grid-template-columns: 80px 1fr 150px; /* 번호, 제목, 작성일 */ align-items: center; padding: 15px 10px; border-bottom: 1px solid #eee; text-align: center; font-size: 15px; }
        .list-item.header { font-weight: bold; background-color: #f9f9f9; }
        .item-no { color: #888; }
        .item-title { text-align: left; }
        .item-title a { text-decoration: none; color: #333; }
        .item-title a:hover { text-decoration: underline; }
        .item-date { color: #888; font-size: 14px;} /* 작성일 컬럼 추가 */

        /* 공지 스타일 */
        .list-item.notice { background-color: #fff9f9; }
        .notice-tag { display: inline-block; background-color: #dc3545; color: white; font-size: 12px; padding: 3px 8px; border-radius: 4px; font-weight: bold; }

        .actions { text-align: right; margin-top: 20px; }
        .btn-write { background-color: #007bff; color: white; border: none; padding: 10px 24px; text-decoration: none; border-radius: 6px; font-weight: bold; }

        /* 페이지네이션 스타일 */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 40px; }
        .pagination a, .pagination strong { display: inline-block; width: 36px; height: 36px; line-height: 36px; text-align: center; border-radius: 6px; text-decoration: none; color: #555; border: 1px solid #ddd; }
        .pagination a:hover { background-color: #e9ecef; }
        .pagination strong { background-color: #007bff; color: white; border-color: #007bff; font-weight: bold; }
    </style>
</head>
<body>
    <%-- 헤더 --%>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <aside class="sidebar">
            <ul> <%-- 사이드바 링크 수정 --%>
                <li><a href="<c:url value='/board/notice/list'/>">공지 사항</a></li>
                <li><a href="<c:url value='/board/faq/list'/>">자주 묻는 질문</a></li>
                <li><a href="<c:url value='/board/qna/list'/>">1:1 문의</a></li>
                <li><a href="<c:url value='/board/report/list'/>" class="active">신고 게시판</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <h1 class="page-title">신고 게시판</h1>
            <div class="list-header">
                 <%-- 검색 기능 구현 시 Controller 수정 필요 --%>
                <form action="<c:url value='/board/report/list'/>" class="search-form" method="get">
                    <select name="condition">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <%-- 신고 게시판 특성상 작성자 검색은 불필요할 수 있음 --%>
                    </select>
                    <input type="text" name="keyword" placeholder="검색어를 입력해주세요" value="${keyword}"> <%-- 검색어 유지 --%>
                    <button type="submit">검색</button>
                </form>
            </div>

            <ul class="report-list">
                <%-- 헤더 컬럼 --%>
                <li class="list-item header">
                    <div class="item-no">번호</div>
                    <div class="item-title">제목</div>
                    <div class="item-date">작성일</div> <%-- 작성일 컬럼 추가 --%>
                </li>

                <%-- Controller에서 고정 공지(pinnedNotice) 객체를 전달받았을 경우 --%>
                <c:if test="${not empty pinnedNotice}">
                    <li class="list-item notice">
                        <div class="item-no"><span class="notice-tag">공지</span></div>
                        <div class="item-title">
                            <%-- 링크 경로 및 파라미터 이름 수정, EL 변수명 수정 --%>
                            <a href="<c:url value='/board/notice/detail?noticeNo=${pinnedNotice.noticeNo}'/>">${pinnedNotice.noticeTitle}</a>
                        </div>
                        <div class="item-date"></div> <%-- 공지 작성일 표시 (선택) --%>
                    </li>
                </c:if>

                <%-- Controller에서 전달받은 신고 목록(reportList) 반복 --%>
                <c:forEach var="report" items="${reportList}">
                    <li class="list-item">
                        <div class="item-no">${report.reportNo}</div>
                        <div class="item-title">
                            <%-- 링크 경로 및 파라미터 이름 수정, EL 변수명 수정 --%>
                            <a href="<c:url value='/board/report/detail?reportNo=${report.reportNo}'/>">${report.reportTitle}</a>
                        </div>
                         <%-- 작성일 표시 (fmt 태그 사용) --%>
                        <div class="item-date"><fmt:formatDate value="${report.writeDate}" pattern="yyyy.MM.dd"/></div>
                    </li>
                </c:forEach>

                <%-- 목록이 없을 경우 메시지 표시 --%>
                 <c:if test="${empty reportList}">
                    <p style="text-align: center; padding: 50px;">등록된 신고가 없습니다.</p>
                </c:if>
            </ul>

            <div class="actions">
                 <%-- 글쓰기 버튼 링크 수정 --%>
                <a href="<c:url value='/board/report/insert'/>" class="btn-write">신고하기</a>
            </div>

            <%-- 페이지네이션 구현 --%>
            <nav class="pagination">
                <%-- 이전 페이지 버튼 --%>
                <c:if test="${currentPage > 1}">
                    <a href="?page=${currentPage - 1}${searchParam}">&lt;</a> <%-- 검색 조건 유지 --%>
                </c:if>

                <%-- 페이지 번호 목록 --%>
                <c:forEach var="p" begin="${startNavi}" end="${endNavi}">
                    <c:choose>
                        <c:when test="${p == currentPage}">
                            <strong>${p}</strong>
                        </c:when>
                        <c:otherwise>
                            <a href="?page=${p}${searchParam}">${p}</a> <%-- 검색 조건 유지 --%>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <%-- 다음 페이지 버튼 --%>
                <c:if test="${currentPage < maxPage}">
                    <a href="?page=${currentPage + 1}${searchParam}">&gt;</a> <%-- 검색 조건 유지 --%>
                </c:if>
            </nav>
        </main>
    </div>
    <%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
</body>
</html>