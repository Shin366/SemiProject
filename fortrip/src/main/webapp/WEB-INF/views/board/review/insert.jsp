<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코스 리뷰 작성</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <style>
        /* General Styles */
        body {
            font-family: 'pretendard', sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 30px;
            color: #333;
        }

        /* Form Layout */
        .review-form {
            display: flex;
            gap: 40px;
        }

        .main-content {
            flex: 3; /* 3:1 ratio for main content vs sidebar */
        }

        .sidebar {
            flex: 1;
        }

        /* Form Groups */
        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #555;
        }

        .form-group input[type="text"],
        .form-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 15px;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        .form-group input[type="text"]:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #007bff;
        }
        
        /* WYSIWYG Editor Placeholder */
        #reviewContent {
            min-height: 450px;
            resize: vertical;
        }
        
        .form-group .guide {
             font-size: 13px;
             color: #888;
             margin-top: 5px;
        }

        /* Sidebar Widgets */
        .widget {
            background-color: #f9fafb;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
            margin-bottom: 25px;
        }

        .widget h3 {
            font-size: 18px;
            margin-top: 0;
            margin-bottom: 15px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        
        /* Course Selection Widget */
        #selectCourseBtn {
            width: 100%;
            padding: 10px;
            background-color: #343a40;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
        }
        #selectedCourseName {
            margin-top: 10px;
            font-size: 14px;
            color: #007bff;
            font-weight: 600;
        }

        /* Rating Widget */
        .rating .stars {
            font-size: 28px;
            color: #ddd;
            cursor: pointer;
        }
        .rating .stars .fa-star:hover,
        .rating .stars .fa-star.selected {
            color: #ffc107;
        }

        /* Image Uploader Widget */
        .image-uploader {
            border: 2px dashed #ddd;
            border-radius: 8px;
            padding: 30px;
            text-align: center;
            cursor: pointer;
            transition: background-color 0.2s, border-color 0.2s;
        }
        .image-uploader:hover {
            background-color: #f8f9fa;
            border-color: #007bff;
        }
        .image-uploader i {
            font-size: 32px;
            color: #adb5bd;
        }
        .image-uploader p {
            margin: 10px 0 0;
            color: #6c757d;
        }

        /* Action Buttons */
        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>

<%-- header
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
--%>

<div class="container">
    <h1>코스 리뷰 작성</h1>

    <form class="review-form" action="/review/insert" method="post" enctype="multipart/form-data">
        
        <%-- 왼쪽 메인 콘텐츠 영역 --%>
        <div class="main-content">
            <div class="form-group">
                <label for="reviewTitle">제목</label>
                <input type="text" id="reviewTitle" name="reviewTitle" placeholder="리뷰의 제목을 입력해주세요" required>
            </div>
            
            <div class="form-group">
                <label for="reviewSubtitle">소제목 (한 줄 요약)</label>
                <input type="text" id="reviewSubtitle" name="reviewSubtitle" placeholder="목록에 표시될 매력적인 한 줄 요약을 작성해주세요">
             <!--    <p class="guide">작성하지 않을 경우, 본문 내용의 일부가 표시될 수 있습니다.</p> -->
            </div>

            <div class="form-group">
                <label for="reviewContent">상세 내용</label>
                <%-- 
                   에디터 알아봐야함
                --%>
                <textarea id="reviewContent" name="reviewContent" placeholder="여행 코스에 대한 상세한 후기를 남겨주세요."></textarea>
            </div>
        </div>

        <%-- 오른쪽 사이드바 영역 --%>
        <div class="sidebar">
            <div class="widget">
                <h3>원본 코스</h3>
                <button type="button" id="selectCourseBtn">리뷰할 코스 선택하기</button>
                <div id="selectedCourseName">선택된 코스가 없습니다.</div>
                
                <%-- DB에 저장될 코스 번호와 타입을 숨겨서 전달합니다. --%>
                <input type="hidden" id="courseId" name="courseId">
                <input type="hidden" id="courseType" name="courseType">
            </div>

            <div class="widget rating">
                <h3>평점</h3>
                <div class="stars">
                    <i class="fa-solid fa-star" data-value="1"></i>
                    <i class="fa-solid fa-star" data-value="2"></i>
                    <i class="fa-solid fa-star" data-value="3"></i>
                    <i class="fa-solid fa-star" data-value="4"></i>
                    <i class="fa-solid fa-star" data-value="5"></i>
                </div>
                <input type="hidden" id="reviewRating" name="reviewRating" value="0" required>
            </div>

            <div class="widget">
                <h3>이미지 첨부</h3>
                <div class="image-uploader" id="imageUploader">
                    <i class="fa-solid fa-cloud-arrow-up"></i>
                    <p>이미지를 드래그하거나<br>클릭해서 업로드하세요</p>
                </div>
                <%-- 실제 파일은 이 input 태그를 통해 처리됩니다. --%>
                <input type="file" id="fileInput" name="reviewImages" multiple hidden>
            </div>

        </div>
    </form>
    
    <div class="form-actions">
        <button type="button" class="btn btn-secondary">취소</button>
        <button type="submit" form="review-form" class="btn btn-primary">등록하기</button>
    </div>

</div>

<%-- 
    footer
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
--%>

<script>
    document.addEventListener('DOMContentLoaded', function() {

        // 1. 코스 선택하기 시뮬레이션
        const selectCourseBtn = document.getElementById('selectCourseBtn');
        const selectedCourseName = document.getElementById('selectedCourseName');
        const courseIdInput = document.getElementById('courseId');
        const courseTypeInput = document.getElementById('courseType');

        selectCourseBtn.addEventListener('click', function() {
            // 실제로는 여기서 모달(팝업) 창을 띄워 코스를 검색/선택하게 됩니다.
            // 지금은 prompt로 간단하게 시뮬레이션합니다.
            const courseName = prompt("선택할 코스 이름을 입력하세요 (예: 제주 동부 3박 4일)");
            if (courseName) {
                selectedCourseName.textContent = `선택된 코스: ${courseName}`;
                // 실제로는 선택된 코스의 고유 ID와 타입을 DB에서 받아와 설정합니다.
                courseIdInput.value = '101'; // 예시 ID
                courseTypeInput.value = 'ADMIN'; // 예시 타입
            }
        });

        // 2. 별점 기능
        const stars = document.querySelectorAll('.rating .stars .fa-star');
        const ratingInput = document.getElementById('reviewRating');

        stars.forEach(star => {
            star.addEventListener('mouseover', function() {
                resetStars();
                const rating = this.dataset.value;
                for (let i = 0; i < rating; i++) {
                    stars[i].classList.add('selected');
                }
            });

            star.addEventListener('mouseout', function() {
                resetStars();
                const currentRating = ratingInput.value;
                if (currentRating > 0) {
                    for (let i = 0; i < currentRating; i++) {
                         stars[i].classList.add('selected');
                    }
                }
            });

            star.addEventListener('click', function() {
                const rating = this.dataset.value;
                ratingInput.value = rating;
            });
        });

        function resetStars() {
            stars.forEach(s => s.classList.remove('selected'));
        }

        // 3. 이미지 업로더
        const imageUploader = document.getElementById('imageUploader');
        const fileInput = document.getElementById('fileInput');

        imageUploader.addEventListener('click', function() {
            fileInput.click();
        });

        fileInput.addEventListener('change', function() {
            const files = this.files;
            if (files.length > 0) {
                // 실제로는 여기서 선택된 파일 목록을 미리보기로 보여주는 로직을 추가합니다.
                alert(`${files.length}개의 파일이 선택되었습니다.`);
            }
        });
    });
</script>

</body>
</html>