<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 내 게시글</title>
<link rel="icon" type="image/png" href="/resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="/resources/css/member/myBoard.css">
</head>
<body>
<div id="container">
    <main id="main">
        <!-- 사이드바 -->
        <div class="sidebar">
            <ul>
                <li><a href="/member/profile">내 프로필</a></li>
                <li><a href="/member/myBoard" class="active">내 게시글</a></li>
                <li><a href="/member/list">찜 목록</a></li>
                <li><a href="/member/recent">최근 본 코스</a></li>
                <li><a href="/member/update">개인 정보 수정</a></li>
                <li><a href="/member/delete">회원탈퇴</a></li>
            </ul>
        </div>

        <!-- 메인 컨텐츠 -->
        <div class="myboard-container">
            <div class="myboard-header">
                <h2>내 게시글</h2>
                <form method="get" action="/member/myBoard" class="filter-form">
                    <select name="type" onchange="this.form.submit()">
                        <option value="all" ${type == 'all' ? 'selected' : ''}>전체</option>
                        <option value="community" ${type == 'community' ? 'selected' : ''}>커뮤니티</option>
                        <option value="review" ${type == 'review' ? 'selected' : ''}>리뷰</option>
                    </select>
                </form>
            </div>

            <!-- 게시글 리스트 -->
            <div class="board-list">
                <c:forEach var="board" items="${boardList}" varStatus="status">
                    <div class="board-card">
                        <!-- ✅ 썸네일 (이미지 없으면 기본 배경) -->
                        <div class="board-thumbnail ${empty board.thumbnailPath ? 'no-image' : ''} ${board.boardType}">
                            <c:choose>
                                <c:when test="${not empty board.thumbnailPath}">
                                    <img src="${board.thumbnailPath}" alt="게시글 썸네일">
                                </c:when>
                                <c:otherwise>
                                    <!-- 이미지 없을 때 아이콘 표시 -->
                                    <svg class="default-icon" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                                        <circle cx="8.5" cy="8.5" r="1.5"/>
                                        <polyline points="21 15 16 10 5 21"/>
                                    </svg>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- 카드 클릭 영역 -->
                        <div class="board-content" onclick="location.href='${board.boardType == 'community' ? '/community/detail?no=' : '/review/detail?no='}${board.boardNo}'">
                            <!-- 카테고리 태그 -->
                            <div class="board-category ${board.boardType}">
                                ${board.boardType == 'community' ? '커뮤니티' : '리뷰'}
                                <c:if test="${board.boardType == 'review' && not empty board.category}">
                                    · ${board.category}
                                </c:if>
                            </div>

                            <!-- 제목 -->
                            <h3 class="board-title">${board.title}</h3>

                            <!-- 작성일 -->
                            <p class="board-date">
                                <fmt:formatDate value="${board.writeDate}" pattern="yyyy년 MM월 dd일" />
                            </p>

                            <!-- 통계 정보 -->
                            <div class="board-stats">
                                <span class="stat-item">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                                        <circle cx="12" cy="12" r="3"/>
                                    </svg>
                                    ${board.viewCount}
                                </span>
                                <span class="stat-item">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/>
                                    </svg>
                                    ${board.bookmarkCount}
                                </span>
                                <span class="stat-item">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
                                    </svg>
                                    ${board.commentCount}
                                </span>
                            </div>
                        </div>

                        <!-- 액션 버튼 -->
                        <div class="board-actions">
                            <a href="${board.boardType == 'community' ? '/community/update?no=' : '/review/update?no='}${board.boardNo}" 
                               class="btn-edit" onclick="event.stopPropagation()">
                                수정
                            </a>
                            <a href="${board.boardType == 'community' ? '/community/delete?no=' : '/review/delete?no='}${board.boardNo}" 
                               class="btn-delete" 
                               onclick="event.stopPropagation(); return confirm('정말 삭제하시겠습니까?')">
                                삭제
                            </a>
                        </div>
                    </div>
                </c:forEach>

                <!-- 게시글 없을 때 -->
                <c:if test="${empty boardList}">
                    <div class="empty-state">
                        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                            <polyline points="14 2 14 8 20 8"/>
                        </svg>
                        <p>작성한 게시글이 없습니다.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </main>
</div>
</body>
</html>