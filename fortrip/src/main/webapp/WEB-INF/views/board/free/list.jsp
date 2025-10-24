<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ForTrip - 커뮤니티</title>
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">    
    <style>
        /* --- 기본 레이아웃  --- */
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; background-color: white; color: #333; }
        .container { display: flex; max-width: 1200px; margin: 30px auto; gap: 30px; }
        .sidebar { flex: 0 0 200px; }
        .main-content { flex-grow: 1; }

        /* --- 사이드바 --- */
        .sidebar ul { list-style: none; padding: 0; background-color: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); padding: 10px; }
        .sidebar a { display: block; padding: 15px 20px; text-decoration: none; color: #555; border-radius: 6px; font-weight: 600; font-size: 16px; }
        .sidebar a.active, .sidebar a:hover { background-color: #007bff; color: white; }

        /* --- 메인 컨텐츠 --- */
        .page-header h1 { font-size: 28px; font-weight: bold; margin-bottom: 8px; }
        .page-header p { color: #888; margin-bottom: 30px; }
        
        .board-controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .search-box { display: flex; border: 1px solid #ddd; border-radius: 6px; }
        .search-box select, .search-box input, .search-box button { border: none; background: none; padding: 10px; font-size: 14px; }
        .search-box input { outline: none; }
        .sort-options select { padding: 10px; border: 1px solid #ddd; border-radius: 6px; }
        
        /* --- 게시판 목록 --- */
        .board-list { border-top: 2px solid #333; }
        .board-list .list-item { display: grid; grid-template-columns: 80px 1fr 120px 180px; align-items: center; padding: 15px 10px; border-bottom: 1px solid #eee; text-align: center; font-size: 15px; }
        .board-list .list-item.header { font-weight: bold; background-color: #f9f9f9; }
        .board-list .post-title { text-align: left; }
        .board-list .post-title a { text-decoration: none; color: #333; }
        .board-list .post-title a:hover { text-decoration: underline; }
        .post-meta { display: flex; justify-content: space-evenly; align-items: center; color: #888; font-size: 14px; }
        
        .list-item.notice { background-color: #fff9f9; }
        .notice .post-no .badge { background-color: #dc3545; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; }
        
        .board-footer { display: flex; justify-content: flex-end; margin-top: 20px; }
        .write-button { background-color: #007bff; color: white; text-decoration: none; padding: 12px 25px; border-radius: 6px; font-weight: bold; }
        
        /* --- 페이지네이션 --- */
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin: 40px 0; }
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
            <ul>
                <li><a href="<c:url value='/board/free/list'/>" class="active">자유 소통</a></li>
                <li><a href="#">코스 리뷰</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="page-header">
                <h1>자유 게시판</h1>
                <p>여행을 좋아하는 사람들의 쉼터, 자유게시판입니다 💬</p>
            </div>

            <div class="board-controls">
                <div class="search-box">
                    <select name="condition">
                        <option value="all">전체</option>
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                    </select>
                    <input type="text" name="keyword" placeholder="검색어를 입력해주세요">
                    <button type="submit">🔍</button>
                </div>
                <div class="sort-options">
                    <select name="sort">
                        <option value="latest">최신순</option>
                        <option value="views">조회순</option>
                        <option value="likes">좋아요순</option>
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

                <c:forEach var="post" items="${fList}">
                    <div class="list-item">
                        <div class="post-no">${post.postNo}</div>
                        <div class="post-title">
                            <a href="<c:url value='/board/free/detail?postNo=${post.postNo}'/>">${post.postTitle}</a>
                        </div>
                        <div class="post-author">${post.postWriter}</div>
                        <div class="post-meta">
	                        <span>👁️ ${post.viewCount}</span>
				            <span>❤️ ${post.likeCount}</span>
				            <span>⭐ ${post.bookmarkCount}</span>
				            <span>💬 ${post.commentCount}</span>
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