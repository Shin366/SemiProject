<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8">
   <title>ForTrip - 커뮤니티</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">   
	<link rel="stylesheet" href="/resources/css/board/free/list.css">   
</head>
<body>
   <%-- 헤더 --%>
   <jsp:include page="/WEB-INF/views/common/header.jsp"/>
   <div class="container">
       <aside class="sidebar">
           <ul>
               <li><a href="<c:url value='/board/free/list'/>" class="active">자유 소통</a></li>
               <li><a href="<c:url value='/board/review/list'/>">코스 리뷰</a></li>
           </ul>
       </aside>
       <main class="main-content">
           <div class="page-header">
               <h1>자유 게시판</h1>
               <p>여행을 좋아하는 사람들의 쉼터, 자유게시판입니다 💬</p>
           </div>
          <div class="board-controls">
			  <form action="<c:url value='/board/free/list'/>" method="get" class="board-search-box">
			      <select name="condition">
			          <option value="all" ${param.condition == 'all' ? 'selected' : ''}>전체</option>
			          <option value="title" ${param.condition == 'title' ? 'selected' : ''}>제목</option>
			          <option value="content" ${param.condition == 'content' ? 'selected' : ''}>내용</option>
			          <option value="writer" ${param.condition == 'writer' ? 'selected' : ''}>작성자</option>
			      </select>
			      <input type="text" name="keyword" value="${param.keyword}" placeholder="검색어를 입력해주세요">
			      <button type="submit">🔍</button>
			  </form>
			
			  <div class="sort-options">
			      <select name="sort" onchange="location.href='?sort=' + this.value">
			          <option value="latest" ${param.sort == 'latest' ? 'selected' : ''}>최신순</option>
			          <option value="views" ${param.sort == 'views' ? 'selected' : ''}>조회순</option>
			          <option value="likes" ${param.sort == 'likes' ? 'selected' : ''}>좋아요순</option>
			      </select>
			  </div>
			</div>
           <div class="board-list">
               <div class="list-item header">
                   <div class="post-no">번호</div>
                   <div class="post-title">제목</div>
                   <div class="post-author">작성자</div>
                   <div class="post-meta">조회 / 좋아요 / 댓글</div>
               </div>
			<!-- 고정 공지 출력 -->
		    <c:if test="${not empty pinnedNotice}">
		        <div class="list-item notice">
		            <div class="post-no"><span class="badge">공지</span></div>
		            <div class="post-title">
		                <a href="<c:url value='/board/notice/detail?noticeNo=${pinnedNotice.noticeNo}'/>">${pinnedNotice.noticeTitle}</a>
		            </div>
		            <div class="post-author">관리자</div>
		            <div class="post-meta">
		                <%-- 공지사항 조회수 표시 --%>
		                <%-- <span>👁️ ${pinnedNotice.viewCount}</span> --%>
		            </div>
		        </div>
		    </c:if>
               <c:forEach var="free" items="${fList}">
                   <div class="list-item">
                       <div class="post-no">${free.postNo}</div>
                       <div class="post-title">
                           <a href="<c:url value='/board/free/detail?postNo=${free.postNo}'/>">${free.postTitle}</a>
                       </div>
                       <div class="post-author">${free.postWriter}</div>
                       <div class="post-meta">
	                        <span>👁️ ${free.viewCount}</span>
				            <span>❤️ ${free.likeCount}</span>
				            <span>⭐ ${free.bookmarkCount}</span>
				            <span>💬 ${free.commentCount}</span>
                       </div>
                   </div>
               </c:forEach>
               <c:if test="${empty fList}">
                   <p style="text-align: center; padding: 50px;">등록된 게시글이 없습니다.</p>
               </c:if>
           </div>
          
           <div class="board-footer">
               <a href="<c:url value='/board/free/insert'/>" class="write-button">게시글 작성</a>
           </div>
           <nav class="pagination">
               <c:if test="${currentPage > 1}">
                   <a href="?page=${currentPage - 1}">&lt;</a>
               </c:if>
               <c:forEach var="p" begin="${startNavi}" end="${endNavi}">
                   <c:choose>
                       <c:when test="${p == currentPage}">
                           <strong>${p}</strong>
                       </c:when>
                       <c:otherwise>
                           <a href="?page=${p}">${p}</a>
                       </c:otherwise>
                   </c:choose>
               </c:forEach>
               <c:if test="${currentPage < maxPage}">
                   <a href="?page=${currentPage + 1}">&gt;</a>
               </c:if>
           </nav>
       </main>
   </div>
   <%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
</body>
</html>
