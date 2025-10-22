<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>코스 리뷰 - 수정 및 삭제</title>
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
        
        /* Form Styles */
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 16px; font-weight: 600; margin-bottom: 8px; }
        .form-group input[type="text"], .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
        }
        .form-group input.title-input { font-size: 24px; font-weight: bold; }
        .form-group textarea { min-height: 400px; resize: vertical; line-height: 1.8; }
        
        .rating-input .stars { font-size: 28px; color: #ddd; cursor: pointer; }
        .rating-input .stars .fa-star:hover,
        .rating-input .stars .fa-star.selected { color: #ffc107; }

        .course-link-wrapper { margin: 25px 0; }
        .course-info { display: block; width: 100%; text-align: center; background-color: #f8f9fa; border: 1px solid #dee2e6; padding: 15px; border-radius: 8px; color: #343a40; font-weight: bold; }
        .course-info i { margin-right: 8px; }

        .bottom-actions { text-align: center; margin-top: 40px; display: flex; justify-content: flex-end; gap: 10px; }
        .btn { padding: 12px 30px; border-radius: 6px; text-decoration: none; font-size: 16px; border: 1px solid #ccc; background-color: #fff; cursor: pointer; }
        .btn-submit { background-color: #007bff; color: white; border: none; }
    </style>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <a href="#">자유 소통</a>
            <a href="#" class="active">코스 리뷰</a>
        </aside>

        <main class="main-content">
            <h1 class="page-title">코스 리뷰 수정</h1>
            
            <form id="editForm" action="/review/update" method="post" enctype="multipart/form-data">
                <%-- 수정 대상 리뷰 번호를 서버로 보내기 위한 hidden input --%>
                <input type="hidden" name="reviewNo" value="${review.reviewNo}">

                <article class="review-article">
                    <div class="form-group">
                        <label for="reviewTitle">제목</label>
                        <input type="text" id="reviewTitle" name="reviewTitle" class="title-input" value="${review.title}" required>
                    </div>
                    
                    <div class="form-group rating-input">
                        <label>별점</label>
                        <div class="stars">
                            <i class="fa-solid fa-star" data-value="1"></i>
                            <i class="fa-solid fa-star" data-value="2"></i>
                            <i class="fa-solid fa-star" data-value="3"></i>
                            <i class="fa-solid fa-star" data-value="4"></i>
                            <i class="fa-solid fa-star" data-value="5"></i>
                        </div>
                        <input type="hidden" id="reviewRating" name="reviewRating" value="${review.rating}" required>
                    </div>

                    <div class="course-link-wrapper">
                         <div class="course-info">
                            <i class="fa-solid fa-route"></i>리뷰 대상 코스: ${review.courseId}
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="reviewSubtitle">부제목</label>
                        <input type="text" id="reviewSubtitle" name="reviewSubtitle" value="${review.subtitle}">
                    </div>
                    
                    <div class="form-group">
                        <label for="reviewContent">본문</label>
                        <textarea id="reviewContent" name="reviewContent">${review.content}</textarea>
                    </div>
                    
                    <div class="form-group">
                        <label for="reviewImage">이미지 변경</label>
                        <p>현재 이미지: <c:if test="${not empty review.imagePath}">${review.originalName}</c:if></p>
                        <input type="file" id="reviewImage" name="reviewImage">
                    </div>

                </article>
            </form>
            
            <div class="bottom-actions">
                <button type="button" class="btn" onclick="history.back()">취소</button>
                <button type="submit" form="editForm" class="btn btn-submit">수정 완료</button>
            </div>
        </main>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const stars = document.querySelectorAll('.rating-input .stars .fa-star');
            const ratingInput = document.getElementById('reviewRating');

            // 페이지 로드 시 기존 별점을 UI에 표시
            const initialRating = ratingInput.value;
            if (initialRating > 0) {
                updateStars(initialRating);
            }

            stars.forEach(star => {
                star.addEventListener('click', function() {
                    const rating = this.dataset.value;
                    ratingInput.value = rating;
                    updateStars(rating);
                });
            });

            function updateStars(rating) {
                stars.forEach(s => {
                    s.classList.remove('selected');
                    if (s.dataset.value <= rating) {
                        s.classList.add('selected');
                    }
                });
            }
        });
    </script>
</body>
</html>