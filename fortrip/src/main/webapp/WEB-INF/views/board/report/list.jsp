<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 게시판 - 고객지원</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="<c:url value='/resources/css/common/header.css'/>"> 
	<link rel="stylesheet" href="<c:url value='/resources/css/common/rset.css'/>"> 
    <link rel="stylesheet" href="<c:url value='/resources/css/common/base-layout.css'/>">
	<link rel="stylesheet" href="<c:url value='/resources/css/board/report/list.css'/>"> 
</head>
<body>
    <!-- header -->
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <aside class="sidebar">
            <ul>
                <li><a href="<c:url value='/board/notice/list'/>">공지 사항</a></li>
                <li><a href="<c:url value='/board/faq/list'/>">자주 묻는 질문</a></li>
                <li><a href="<c:url value='/board/qna/list'/>">1:1 문의</a></li>
                <li><a href="<c:url value='/board/report/list'/>" class="active">신고 게시판</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <h1 class="page-title">신고 게시판</h1>

            <ul class="report-list">
                <li class="list-item header">
                    <div class="item-no">번호</div>
                    <div class="item-title">제목</div>
                    <div class="item-date">작성일</div> 
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
                            <a href="<c:url value='/board/report/detail?reportNo=${report.reportNo}'/>">${report.reportTitle}</a>
                        </div>
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
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>