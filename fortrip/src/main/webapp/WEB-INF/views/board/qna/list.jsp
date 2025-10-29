<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 - 문의 게시판 목록</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">
	<link rel="stylesheet" href="/resources/css/board/qna/list.css">
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
            <h1 class="page-title">문의 사항</h1>
            <div class="list-header">
                <form action="/notice/list" class="search-form">
                    <select name="condition">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                    </select>
                    <input type="text" name="keyword" placeholder="검색어를 입력해주세요">
                    <button type="submit">검색</button>
                </form>
            </div>

            <ul class="qna-list">
                <c:forEach var="qna" items="${qList}">
                    <li class="qna-item">
                        <a href="/board/qna/detail?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a>
                        <span class="writer">${qna.writer}</span>
                    </li>
                </c:forEach>
            </ul>
            
             <div class="actions">
                 <%-- 글쓰기 버튼 링크 수정 --%>
                <a href="<c:url value='/board/qna/insert'/>" class="btn-write">문의하기</a>
            </div>

            <nav class="pagination">
                <c:if test="${startNavi ne 1 }">
                     <a href="/board/qna/list?page=${startNavi - 1 }" class="prev">&laquo; 이전</a>
	                   	</c:if>
	                       <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
		                        <a href="/board/qna/list?page=${n }" class='page-number <c:if test="${currentPage eq n }">active</c:if>'>${n }</a>
	                       </c:forEach>
                 <c:if test="${endNavi ne maxPage }">
                      <a href="/board/qna/list?page=${endNavi + 1 }" class="next">다음 &raquo;</a>
                 </c:if>
            </nav>
        </main>
    </div>
</body>
</html>