<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코스 리뷰 수정</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
    <link rel="stylesheet" href="<c:url value='/resources/css/common/header.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/board/review/insert.css'/>">
    <style>
        .current-thumbnail img {
            max-width: 100%;
            border-radius: 5px;
            margin-top: 10px;
        }
        .course-display {
            padding: 12px 10px;
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            font-weight: bold;
            color: #495057;
            margin-bottom: 8px;
        }
        /* 모달 관련 스타일 */
        .modal-overlay {
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0,0,0,0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
        }
        .course-list { max-height: 400px; overflow-y: auto; margin-top: 10px; }
        .course-item {
            padding: 10px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }
        .course-item:hover { background: #f7f7f7; }
        .btn-close-modal {
            margin-top: 15px;
            background: #6c757d;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-close-modal:hover { background: #5a6268; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="container">
    <h1>코스 리뷰 수정</h1>

    <form class="review-form" id="review-form" action="<c:url value='/board/review/update'/>" method="post" enctype="multipart/form-data">
        <input type="hidden" name="reviewNo" value="${review.reviewNo}">

        <div class="main-content">
            <div class="form-group">
                <label for="reviewTitle">제목</label>
                <input type="text" id="reviewTitle" name="reviewTitle" value="${review.reviewTitle}" required>
            </div>

            <div class="form-group">
                <label for="reviewSubtitle">소제목</label>
                <input type="text" id="reviewSubtitle" name="reviewSubtitle" value="${review.reviewSubtitle}">
            </div>

            <div class="form-group">
                <label for="reviewContent">상세 내용</label>
                <textarea id="reviewContent" name="reviewContent" required>${review.reviewContent}</textarea>
            </div>
        </div>

        <div class="sidebar">
            <div class="form-group">
                <label>리뷰 코스</label>
                <div id="selectedCourse" class="course-display">현재 코스 번호: ${review.roadNo}</div>
                <input type="hidden" id="roadNo" name="roadNo" value="${review.roadNo}">
                <button type="button" id="selectCourseBtn" class="btn btn-outline">코스 변경하기</button>
            </div>

            <div class="widget rating">
                <h3>평점 <span style="color:red;">*</span></h3>
                <div class="stars">
                    <i class="fa-solid fa-star" data-value="1"></i>
                    <i class="fa-solid fa-star" data-value="2"></i>
                    <i class="fa-solid fa-star" data-value="3"></i>
                    <i class="fa-solid fa-star" data-value="4"></i>
                    <i class="fa-solid fa-star" data-value="5"></i>
                </div>
                <input type="hidden" id="reviewRating" name="reviewRating" value="${review.reviewRating}" required>
            </div>

            <div class="widget">
                <h3>현재 썸네일</h3>
                <div class="current-thumbnail">
                    <c:choose>
                        <c:when test="${not empty review.thumbnailPath}">
                            <img src="${pageContext.request.contextPath}${review.thumbnailPath}" alt="현재 이미지">
                        </c:when>
                        <c:otherwise><p>등록된 이미지가 없습니다.</p></c:otherwise>
                    </c:choose>
                </div>
            </div>

            <div class="widget">
                <h3>새 썸네일</h3>
                <div class="image-uploader" id="imageUploader">
                    <i class="fa-solid fa-cloud-arrow-up"></i>
                    <p>새 이미지를 드래그하거나<br>클릭해서 업로드하세요</p>
                </div>
                <input type="file" id="fileInput" name="reloadFiles" hidden>
                <div id="imagePreview" style="margin-top: 15px;"></div>
            </div>
        </div>
    </form>

    <div class="form-actions">
        <button type="button" class="btn btn-secondary" onclick="location.href='<c:url value='/board/review/detail?reviewNo=${review.reviewNo}'/>'">취소</button>
        <button type="submit" form="review-form" class="btn btn-primary">수정하기</button>
    </div>
</div>

<!-- 코스 선택 모달 -->
<div id="courseModal" class="modal-overlay">
    <div class="modal-content">
        <h2>코스 선택</h2>
        <div id="courseList" class="course-list"></div>
        <button type="button" class="btn-close-modal">닫기</button>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {

    // --- 별점 표시 ---
    const stars = document.querySelectorAll('.rating .stars .fa-star');
    const ratingInput = document.getElementById('reviewRating');
    function highlightStars(rating) {
        for (let i = 0; i < rating; i++) stars[i]?.classList.add('selected');
    }
    function resetStars() { stars.forEach(s => s.classList.remove('selected')); }
    stars.forEach(star => {
        star.addEventListener('mouseover', () => { resetStars(); highlightStars(star.dataset.value); });
        star.addEventListener('mouseout', () => { resetStars(); highlightStars(ratingInput.value); });
        star.addEventListener('click', () => { ratingInput.value = star.dataset.value; highlightStars(ratingInput.value); });
    });
    highlightStars(ratingInput.value);

    // --- 이미지 업로드 ---
    const uploader = document.getElementById('imageUploader');
    const fileInput = document.getElementById('fileInput');
    const preview = document.getElementById('imagePreview');
    uploader.addEventListener('click', () => fileInput.click());
    uploader.addEventListener('dragover', e => { e.preventDefault(); uploader.style.borderColor = '#007bff'; });
    uploader.addEventListener('dragleave', () => uploader.style.borderColor = '#ddd');
    uploader.addEventListener('drop', e => {
        e.preventDefault();
        uploader.style.borderColor = '#ddd';
        fileInput.files = e.dataTransfer.files;
        showPreview(fileInput.files);
    });
    fileInput.addEventListener('change', () => showPreview(fileInput.files));
    function showPreview(files) {
        preview.innerHTML = '';
        if (files.length > 0 && files[0].type.startsWith('image/')) {
            const reader = new FileReader();
            reader.onload = e => {
                const img = document.createElement('img');
                img.src = e.target.result;
                img.style.maxWidth = '80px';
                img.style.borderRadius = '5px';
                preview.appendChild(img);
            };
            reader.readAsDataURL(files[0]);
        }
    }

    // --- 코스 선택 모달 ---
    const modal = document.getElementById('courseModal');
    const openBtn = document.getElementById('selectCourseBtn');
    const closeBtn = document.querySelector('.btn-close-modal');
    const courseList = document.getElementById('courseList');
    const selected = document.getElementById('selectedCourse');
    const roadNoInput = document.getElementById('roadNo');

    openBtn.addEventListener('click', async () => {
        modal.style.display = 'flex';
        try {
            const res = await fetch('/review/trip/list');
            if (!res.ok) throw new Error('서버 오류: ' + res.status);
            const list = await res.json();

            courseList.innerHTML = '';
            list.forEach(r => {
                const item = document.createElement('div');
                item.className = 'course-item';
                item.dataset.roadNo = r.roadNo;
                item.dataset.roadName = r.roadName;
                item.textContent = r.roadNo + ' : ' + r.roadName;
                courseList.appendChild(item);
            });
        } catch (err) {
            alert('코스 목록을 불러오지 못했습니다.');
            console.error(err);
        }
    });

    closeBtn.addEventListener('click', () => modal.style.display = 'none');
    modal.addEventListener('click', e => { if (e.target === modal) modal.style.display = 'none'; });

    courseList.addEventListener('click', e => {
        const item = e.target.closest('.course-item');
        if (!item) return;
        roadNoInput.value = item.dataset.roadNo;
        selected.textContent = '선택된 코스: ' + item.dataset.roadName;
        modal.style.display = 'none';
    });

});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>
