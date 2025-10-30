<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 최근 본 코스</title>
<link rel="icon" type="image/png" href="/resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="../../../resources/css/member/recent.css">
</head>
<body>
<div id="container">
    <main id="main">
        <!-- 사이드바 -->
        <div class="sidebar">
            <ul>
                <li><a href="/member/profile">내 프로필</a></li>
                <li><a href="/member/myBoard">내 게시글</a></li>
                <li><a href="/member/list">찜 목록</a></li>
                <li><a href="/member/recent" class="active">최근 본 코스</a></li>
                <li><a href="/member/update">개인 정보 수정</a></li>
                <li><a href="/member/delete">회원탈퇴</a></li>
            </ul>
        </div>

        <!-- 메인 컨텐츠 -->
        <div class="recent-container">
            <div class="recent-header">
                <h2>최근 본 코스</h2>
            </div>

            <!-- 최근 본 코스 리스트 -->
            <div class="recent-list">
                <!-- ✅ forEach 수정 (언더스코어 제거) -->
                <c:forEach var="trip" items="${recentList}">
                    <div class="trip-card" onclick="location.href='/trip/coursedetail/${trip.courseId}'">
                        <div class="trip-thumbnail">
                            <c:choose>
                                <c:when test="${not empty trip.courseId}">
                                    <img src="/resources/img/course/${trip.courseId}.jpg"
                                         alt="${trip.roadName}"
                                         onerror="this.onerror=null; this.src='/resources/img/common/no-image.png';" />
                                </c:when>
                                <c:otherwise>
                                    <div class="no-image">
                                        <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                            <rect x="3" y="3" width="18" height="18" rx="2" ry="2"/>
                                            <circle cx="8.5" cy="8.5" r="1.5"/>
                                            <polyline points="21 15 16 10 5 21"/>
                                        </svg>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="trip-info">
                            <h3 class="trip-title">${trip.roadName}</h3>
                            <p class="trip-location">
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                                    <circle cx="12" cy="10" r="3"/>
                                </svg>
                                ${trip.roadLocation}
                            </p>
                            <p class="trip-cost">${trip.roadCost}</p>
                            <p class="trip-date">
                                조회: <fmt:formatDate value="${trip.viewDate}" pattern="yyyy-MM-dd HH:mm" />
                            </p>
                        </div>
                    </div>
                </c:forEach>

                <!-- ✅ 최근 본 코스가 없을 때 -->
                <c:if test="${empty recentList}">
                    <div class="empty-state">
                        <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
                            <circle cx="12" cy="12" r="3"/>
                        </svg>
                        <p>최근 본 코스가 없습니다.</p>
                        <a href="/" class="btn-primary">코스 둘러보기</a>
                    </div>
                </c:if>
            </div>

            <!-- ✅ 페이지네이션 -->
            <c:if test="${not empty recentList}">
                <div class="pagination">
                    <c:if test="${page > 1}">
                        <a href="?page=${page - 1}" class="page-btn">이전</a>
                    </c:if>
                    
                    <span class="current-page">${page}</span>
                    
                    <c:if test="${recentList.size() == 20}">
                        <a href="?page=${page + 1}" class="page-btn">다음</a>
                    </c:if>
                </div>
            </c:if>
        </div>
    </main>
</div>
</body>
</html>
