<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 최근 본 코스</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
</head>
<body>
	<div id="container">
        <main id="main">
            <div class="recent-container">
                <div class="recent-title">
                    <h2>최근 본 코스</h2>
                </div>
                <button onclick="edit">편집</button>
            </div>
            <div class="mainbar">
    		<c:forEach var="trip" items="${recentList}">
        <div class="trip-item" onclick="location.href='/trip/coursedetail/${trip.courseId}'">
    		<div class="img">
        <img src="/resources/img/course/${trip.courseId}.jpg" alt="${trip.roadName}" />
				</div>
				    <div class="tripdate">${trip.viewDate}</div>
				    <div class="title">${trip.roadName}</div>
				    <div class="price">${trip.roadCost}</div>
				    <div class="location">${trip.roadLocation}</div>
				</div>
		    </c:forEach>
		
		    <div class="pagination">
		        <c:if test="${page > 1}">
		            <a href="?page=${page - 1}">이전</a>
		        </c:if>
		        <span>${page}</span>
		        <c:if test="${recentList.size() == 20}">
		            <a href="?page=${page + 1}">다음</a>
		        </c:if>
		    </div>
		</div>
        </main>
    </div>
</body>
</html>