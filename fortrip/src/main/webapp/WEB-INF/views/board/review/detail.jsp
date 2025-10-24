<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>코스 리뷰</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        body { font-family: sans-serif; background-color: #f8f9fa; margin: 0; }
        .container { display: flex; max-width: 1200px; margin: 20px auto; gap: 20px; }
        .sidebar { flex: 0 0 180px; }
        .sidebar a { display: block; padding: 12px 20px; text-decoration: none; color: #333; border-radius: 8px; font-weight: 500; }
        .sidebar a.active { background-color: #007bff; color: white; font-weight: bold; }
        .main-content { flex-grow: 1; background-color: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }

        .review-article { max-width: 900px; margin: 0 auto; }
        .page-title { font-size: 28px; font-weight: bold; margin-top: 0; margin-bottom: 30px; }
        
        .post-header .post-title { font-size: 28px; margin: 0; display: inline-block; margin-right: 10px; }
        .post-header .post-rating .fa-star { color: #ffc107; font-size: 20px; }
        .post-meta { display: flex; align-items: center; gap: 15px; color: #888; font-size: 14px; margin-top: 10px; padding-bottom: 20px; border-bottom: 1px solid #eee; }
        
        /* '원본 코스 보러가기' 버튼 스타일 */
        .course-link-wrapper { margin: 25px 0; }
        .btn-course-link { display: inline-block; width: 100%; text-align: center; background-color: #f8f9fa; border: 1px solid #dee2e6; padding: 15px; border-radius: 8px; text-decoration: none; color: #343a40; font-weight: bold; transition: background-color 0.2s; }
        .btn-course-link:hover { background-color: #e9ecef; }
        .btn-course-link i { margin-right: 8px; }

        .post-body { padding: 30px 0; }
        .post-subtitle { font-weight: bold; color: #333; font-size: 1.1em; }
        .post-content { margin-top: 20px; font-size: 16px; line-height: 1.8; color: #333; }
        .post-content img { max-width: 100%; height: auto; border-radius: 8px; margin: 20px 0; }

        .post-footer { display: flex; justify-content: space-between; align-items: center; padding: 20px 0; border-top: 1px solid #eee; border-bottom: 1px solid #eee;}
        .reaction-buttons { display: flex; gap: 8px; }
        .reaction-buttons .btn { display: flex; align-items: center; gap: 5px; background-color: #f1f3f5; border: 1px solid #dee2e6; padding: 8px 12px; border-radius: 15px; cursor: pointer; font-size: 14px; }
        .social-share a { color: #888; font-size: 24px; margin-left: 15px; }
        
        .comments-section { margin-top: 30px; }
        .comment-form textarea { width: 100%; min-height: 80px; padding: 12px; border: 1px solid #ccc; border-radius: 6px; resize: vertical; box-sizing: border-box; }
        .comment-form-actions { text-align: right; margin-top: 10px; }
        .btn-submit { background-color: #007bff; color: white; border: none; padding: 8px 18px; }
        .comment-list { margin-top: 30px; }
        .comment-item { padding: 20px 0; border-top: 1px solid #f1f1f1; }
        .comment-author { font-weight: bold; margin-bottom: 5px; }

        .bottom-actions { text-align: center; margin-top: 40px; }
        .btn-list { background-color: #007bff; color: white; border: none; padding: 12px 30px; text-decoration: none; border-radius: 6px; }
    </style>
</head>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<body>
    <div class="container">
        <aside class="sidebar">
            <a href="/board/free/list">자유 소통</a>
            <a href="/board/review/list" class="active">코스 리뷰</a>
        </aside>

        <main class="main-content">
            <h1 class="page-title">코스 리뷰</h1>
            
            <article class="review-article">
                <header class="post-header">
                    <h2 class="post-title">${review.reviewTitle}</h2>
                    <span class="post-rating">
                        <c:forEach begin="1" end="5" var="i">
                            <!-- <i class="fa-solid fa-star" style="${i <= review.rating ? '' : 'color:#ddd;'}"></i> -->
                        </c:forEach>
                    </span>
                    <div class="post-meta">
                        <span>${review.reviewWriter}</span>
                        <span><fmt:formatDate value="${review.writeDate}" pattern="yyyy.MM.dd HH:mm"/></span>
                        <span>조회 ${review.viewCount}</span>
                    </div>
                </header>
                
                <div class="course-link-wrapper">
                    <c:choose>
                        <c:when test="${review.reviewerType == 'ADMIN'}">
                            <a href="/road/admin/${review.roadNo}" class="btn-course-link">
                                <i class="fa-solid fa-route"></i>원본 코스 정보 보러가기
                            </a>
                        </c:when>
                        <c:when test="${review.reviewerType == 'USER'}">
                             <a href="/road/user/${review.roadNo}" class="btn-course-link">
                                <i class="fa-solid fa-route"></i>원본 코스 정보 보러가기
                            </a>
                        </c:when>
                    </c:choose>
                </div>

                <section class="post-body">
                    <p class="post-subtitle">${review.reviewSubtitle}</p>
                    <div class="post-content">
                        <%-- 본문 내용 --%>
                        <p>${review.reviewContent}</p>
                        <img src="https://i.imgur.com/k2jB25m.jpeg" alt="리뷰 이미지">
                    </div>
                </section>
            </article>

            <footer class="post-footer">
                <div class="reaction-buttons">
                    <button class="btn"><i class="fa-regular fa-heart"></i> ${review.likeCount}</button>
                    <button class="btn"><i class="fa-regular fa-bookmark"></i> ${review.bookmarkCount}</button>
                    <button class="btn">신고</button>
                </div>
                <div class="social-share">
                    <a href="#"><i class="fab fa-facebook-square"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </footer>
            
            <section class="comments-section">
                <div class="comment-form">
                    <form action="/comment/write" method="post">
                        <input type="hidden" name="boardNo" value="${review.reviewNo}">
                        <input type="hidden" name="boardType" value="REVIEW">
                        <textarea name="commentContent" placeholder="댓글을 입력해주세요..."></textarea>
                        <div class="comment-form-actions">
                            <button type="submit" class="btn btn-submit">작성</button>
                        </div>
                    </form>
                </div>

                <div class="comment-list">
                    <c:forEach var="comment" items="${commentList}">
                        <div class="comment-item">
                            <p class="comment-author">${comment.authorNickname}</p>
                            <p class="comment-content">${comment.content}</p>
                        </div>
                    </c:forEach>
                </div>
            </section>
            
            <div class="bottom-actions">
                <a href="/board/review/list" class="btn-list">게시글 목록</a>
            </div>
        </main>
    </div>
</body>
</html>