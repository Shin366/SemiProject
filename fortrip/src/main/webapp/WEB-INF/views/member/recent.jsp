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
        <!-- 상단 타이틀 -->
        <div class="recent-header">
            <h2>최근 본 코스</h2>
        </div>

        <!-- 최근 본 코스 리스트 -->
        <div class="recent-list">
            <!-- ✅ 최근 본 코스 있을 때 -->
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
                                <img src="/resources/img/common/no-image.png" alt="이미지 없음" />
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="trip-info">
                        <div class="trip-title">${trip.roadName}</div>
                        <div class="trip-location">${trip.roadLocation}</div>
                        <div class="trip-cost">${trip.roadCost}</div>
                        <div class="trip-date">
                            <fmt:formatDate value="${trip.viewDate}" pattern="yyyy-MM-dd HH:mm" />
                        </div>
                    </div>
                </div>
            </c:forEach>

            <!-- ✅ 최근 본 코스가 없을 때 -->
            <c:if test="${empty recentList}">
                <div class="empty-state">
                    <img src="/resources/img/common/no-history.png" alt="최근 본 코스 없음" class="empty-icon" />
                    <p>최근 본 코스가 없습니다.</p>
                </div>
            </c:if>
        </div>

        <!-- ✅ 페이지네이션 -->
        <div class="pagination">
            <c:if test="${page > 1}">
                <a href="?page=${page - 1}">이전</a>
            </c:if>
            <span>${page}</span>
            <c:if test="${recentList.size() == 20}">
                <a href="?page=${page + 1}">다음</a>
            </c:if>
        </div>
    </main>
</div>
</body>
</html>
