<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            min-height: 450px; /* 에디터 높이 조정 */
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
        #selectRoadBtn { /* 버튼 ID 수정 */
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
            margin-top: 30px; /* 폼과 버튼 사이 간격 */
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
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="container">
    <h1>코스 리뷰 작성</h1>

    <%-- 폼 ID 추가 --%>
    <form class="review-form" id="review-form" action="/board/review/insert" method="post" enctype="multipart/form-data">

        <%-- 왼쪽 메인 콘텐츠 영역 --%>
        <div class="main-content">
            <div class="form-group">
                <label for="reviewTitle">제목</label>
                <input type="text" id="reviewTitle" name="reviewTitle" placeholder="리뷰의 제목을 입력해주세요" required>
            </div>

            <div class="form-group">
                <label for="reviewSubtitle">소제목 (한 줄 요약)</label>
                <input type="text" id="reviewSubtitle" name="reviewSubtitle" placeholder="목록에 표시될 한 줄 요약을 작성해주세요">
            </div>

            <div class="form-group">
                <label for="reviewContent">상세 내용</label>
                <%-- TODO: WYSIWYG 에디터 라이브러리(Summernote, CKEditor 등) 적용 필요 --%>
                <textarea id="reviewContent" name="reviewContent" placeholder="여행 코스에 대한 상세한 후기를 남겨주세요." required></textarea>
            </div>
        </div>

        <%-- 오른쪽 사이드바 영역 --%>
        <div class="sidebar">
            <div class="widget">
                <h3>원본 코스</h3>
                <%-- 버튼 ID 수정 --%>
                <button type="button" id="selectRoadBtn">리뷰할 코스 선택하기</button>
                <div id="selectedCourseName">선택된 코스가 없습니다.</div>

                <%-- Hidden Input ID/Name 수정 ('r' 소문자) --%>
                <input type="hidden" id="roadNo" name="roadNo">
                <%-- reviewerType은 로그인 사용자 정보 기반으로 서버에서 설정하는 것이 안전할 수 있음 --%>
                <input type="hidden" id="reviewerType" name="reviewerType" value="USER">
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
                <input type="hidden" id="reviewRating" name="reviewRating" value="0" required>
            </div>

            <div class="widget">
                <h3>이미지 첨부</h3>
                <div class="image-uploader" id="imageUploader">
                    <i class="fa-solid fa-cloud-arrow-up"></i>
                    <p>이미지를 드래그하거나<br>클릭해서 업로드하세요</p>
                </div>
                <input type="file" id="fileInput" name="files" multiple hidden>
                <%-- 이미지 미리보기 영역 (선택 사항) --%>
                <div id="imagePreview" style="margin-top: 15px;"></div>
            </div>

        </div>
    </form> 

    <%-- 버튼들을 form 밖에 두되, submit 버튼에 form 속성 연결 --%>
    <div class="form-actions">
        <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
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
        const selectRoadBtn = document.getElementById('selectRoadBtn'); // ID 수정
        const selectedCourseName = document.getElementById('selectedCourseName');
        const roadNoInput = document.getElementById('roadNo'); // ID/변수명 수정
        const reviewerTypeInput = document.getElementById('reviewerType'); // 변수명 수정

        selectRoadBtn.addEventListener('click', function() {
            const courseName = prompt("선택할 코스 이름을 입력하세요 (예: 제주 동부 3박 4일)");
            if (courseName) {
                selectedCourseName.textContent = `선택된 코스: ${courseName}`;
                // 실제로는 선택된 코스의 고유 ID와 타입을 받아와 설정
                roadNoInput.value = '101'; // 예시 ID (실제 값으로 변경 필요)
                // reviewerTypeInput.value = 'ADMIN'; // 예시 타입 (USER로 고정하거나 로직 추가)
            }
        });

        // 2. 별점 기능
        const stars = document.querySelectorAll('.rating .stars .fa-star');
        const ratingInput = document.getElementById('reviewRating');

        stars.forEach(star => {
            star.addEventListener('mouseover', function() {
                resetStars();
                highlightStars(this.dataset.value);
            });

            star.addEventListener('mouseout', function() {
                resetStars();
                highlightStars(ratingInput.value); // 현재 선택된 값 기준으로 다시 표시
            });

            star.addEventListener('click', function() {
                ratingInput.value = this.dataset.value; // 클릭 시 값 설정
                highlightStars(ratingInput.value); // 클릭된 상태 반영
            });
        });

        function highlightStars(rating) {
            for (let i = 0; i < rating; i++) {
                if (stars[i]) { // Check if star exists
                    stars[i].classList.add('selected');
                }
            }
        }

        function resetStars() {
            stars.forEach(s => s.classList.remove('selected'));
        }

        // 3. 이미지 업로더
        const imageUploader = document.getElementById('imageUploader');
        const fileInput = document.getElementById('fileInput');
        const imagePreview = document.getElementById('imagePreview'); // 미리보기 영역

        imageUploader.addEventListener('click', () => fileInput.click());

        // Drag and Drop 
        imageUploader.addEventListener('dragover', (e) => {
            e.preventDefault();
            imageUploader.style.borderColor = '#007bff';
        });
        imageUploader.addEventListener('dragleave', () => {
             imageUploader.style.borderColor = '#ddd';
        });
        imageUploader.addEventListener('drop', (e) => {
            e.preventDefault();
            imageUploader.style.borderColor = '#ddd';
            fileInput.files = e.dataTransfer.files; // 드롭된 파일들을 input에 설정
            handleFiles(fileInput.files); // 파일 처리 함수 호출
        });


        fileInput.addEventListener('change', () => handleFiles(fileInput.files));

        function handleFiles(files) {
            imagePreview.innerHTML = ''; // 기존 미리보기 초기화
            if (files.length > 0) {
                 imageUploader.querySelector('p').textContent = `${files.length}개의 파일 선택됨`; // 메시지 변경

                // 간단한 이미지 미리보기
                for (const file of files) {
                    if (file.type.startsWith('image/')) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            const img = document.createElement('img');
                            img.src = e.target.result;
                            img.style.maxWidth = '80px';
                            img.style.maxHeight = '80px';
                            img.style.margin = '5px';
                            imagePreview.appendChild(img);
                        }
                        reader.readAsDataURL(file);
                    }
                }
            } else {
                 imageUploader.querySelector('p').innerHTML = '이미지를 드래그하거나<br>클릭해서 업로드하세요';
            }
        }
    });
</script>

</body>
</html>