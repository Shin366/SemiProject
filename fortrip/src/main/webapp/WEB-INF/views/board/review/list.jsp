<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>코스 리뷰 페이지</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { font-family: sans-serif; background-color: #f8f9fa; margin: 0; }
        .container { display: flex; max-width: 1200px; margin: 20px auto; gap: 20px; }
        .sidebar { flex: 0 0 180px; }
        .sidebar a { display: block; padding: 12px 20px; text-decoration: none; color: #333; border-radius: 8px; font-weight: 500; }
        .sidebar a.active { background-color: #007bff; color: white; font-weight: bold; }
        .main-content { flex-grow: 1; }
        .header-section { margin-bottom: 30px; }
        .page-title { font-size: 28px; font-weight: bold; margin: 0 0 10px 0; }
        .page-subtitle { color: #888; }
        .review-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        .review-card { background-color: #fff; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); overflow: hidden; text-decoration: none; color: inherit; transition: transform 0.2s, box-shadow 0.2s; }
        .review-card:hover { transform: translateY(-5px); box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .card-thumbnail { width: 100%; height: 180px; background-color: #e9ecef; display: flex; align-items: center; justify-content: center; }
        .card-thumbnail img { width: 100%; height: 100%; object-fit: cover; }
        .card-body { padding: 15px; }
        .card-title { font-size: 16px; font-weight: bold; margin: 0 0 5px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .card-subtitle { font-size: 14px; color: #666; margin: 0 0 10px 0; }
        .card-rating .fa-star { color: #ffc107; }
        .card-meta { display: flex; align-items: center; gap: 15px; font-size: 12px; color: #aaa; margin-top: 15px; border-top: 1px solid #f1f1f1; padding-top: 10px;}
        .meta-item { display: flex; align-items: center; gap: 4px; }
        .actions { text-align: right; margin: 30px 0; }
        .btn-write { background-color: #007bff; color: white; border: none; padding: 12px 25px; border-radius: 6px; text-decoration: none; font-size: 16px; }
        .pagination { display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 40px; }
        .pagination a, .pagination strong { display: inline-block; width: 32px; height: 32px; line-height: 32px; text-align: center; border-radius: 4px; text-decoration: none; color: #333; }
        .pagination a:hover { background-color: #e9ecef; }
        .pagination strong { background-color: #007bff; color: white; font-weight: bold; }
    </style>
</head>
<body>
    <%-- 헤더 영역 --%>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <aside class="sidebar">
            <a href="/board/free/list">자유 소통</a>
            <a href="/board/review/list" class="active">코스 리뷰</a>
        </aside>

        <main class="main-content">
            <div class="header-section">
                <h1 class="page-title">코스 리뷰</h1>
                <p class="page-subtitle">For Trip 의 코스에 대해서 자유롭게 리뷰해보세요! 🤗</p>
            </div>
            
            <div class="review-grid">
                <%-- Controller에서 전달한 리뷰 목록(reviewList)을 반복문으로 출력 --%>
                <c:forEach var="review" items="${reviewList}">
                    <a href="/board/review/detail?reviewNo=${review.reviewNo}" class="review-card">
                        <div class="card-thumbnail">
                            <%-- 썸네일 이미지가 있으면 표시, 없으면 기본 이미지 --%>
                            <c:choose>
                                <c:when test="${not empty review.thumbnailPath}">
                                    <img src="${review.thumbnailPath}" alt="${review.title}">
                                </c:when>
                                <c:otherwise>
                                    <i class="fa-regular fa-image fa-3x" style="color:#ccc;"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="card-body">
                            <h3 class="card-title">${review.reviewTitle}</h3>
                            <p class="card-subtitle">${review.reviewSubtitle}</p>
                            <div class="card-rating">
                                <%-- 별점 표시 로직 (예: 5점 만점) --%>
                                <c:forEach begin="1" end="5" var="i">
                                    <c:choose>
                                        <c:when test="${i <= review.reviewRating}">
                                            <i class="fa-solid fa-star" style="color:#ffc107;"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fa-solid fa-star" style="color:#ddd;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </div>
                            <div class="card-meta">
                                <span class="meta-item"><i class="fa-regular fa-eye"></i> ${review.viewCount}</span>
                                <span class="meta-item"><i class="fa-regular fa-comment"></i> ${review.commentCount}</span>
                                <span class="meta-item"><i class="fa-regular fa-heart"></i> ${review.likeCount}</span>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
           
            <div class="actions">
                <a href="/board/review/insert" class="btn-write">게시글 작성</a>
            </div>

            <%-- 페이지네이션 로직 --%>
           <div class="pagination">
                <c:if test="${startNavi ne 1 }">
                    <a href="/board/review/list?page=${startNavi - 1 }" class="prev">&laquo; 이전</a>
               	</c:if>
                    <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                      <a href="/board/review/list?page=${n }" class='page-number <c:if test="${currentPage eq n }">active</c:if>'>${n }</a>
                    </c:forEach>
                    <c:if test="${endNavi ne maxPage }">
                      <a href="/board/review/list?page=${endNavi + 1 }" class="next">다음 &raquo;</a>
                    </c:if>
            </div>
        </main>
    </div>
</body>
</html>