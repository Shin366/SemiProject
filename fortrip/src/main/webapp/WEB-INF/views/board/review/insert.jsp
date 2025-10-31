<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코스 리뷰 작성</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
    <link rel="stylesheet" href="<c:url value='/resources/css/common/header.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/board/review/insert.css'/>">
    
    <style>
        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            /* 기본적으로 숨김 */
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }
        .modal-content {
            background: white;
            padding: 25px;
            border-radius: 8px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .modal-content h2 {
            margin-top: 0;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .course-list {
            max-height: 400px;
            overflow-y: auto;
            margin: 15px 0;
        }
		.course-item {
		  color: #000;
		  background-color: #fff !important;
		  font-size: 16px;
		}
        .course-item:hover {
            background-color: #f9f9f9;
            font-weight: 500;
        }
        .course-item:last-child {
            border-bottom: none;
        }
        .btn-close-modal {
            float: right;
            background: #6c757d;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-close-modal:hover {
            background: #5a6268;
        }
    </style>
    
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="container">
    <h1>코스 리뷰 작성</h1>

    <form class="review-form" id="review-form" action="/board/review/insert" method="post" enctype="multipart/form-data">
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
                <textarea id="reviewContent" name="reviewContent" placeholder="여행 코스에 대한 상세한 후기를 남겨주세요." required></textarea>
            </div>
        </div>

        <div class="sidebar">
            <div class="form-group">
                <button type="button" id="selectRoadBtn">리뷰할 코스 선택하기</button>
                <div id="selectedCourseName">선택된 코스가 없습니다.</div>
                <input type="hidden" id="roadNo" name="roadNo" value="">
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
                <h3>썸네일 이미지 첨부</h3>
                <div class="image-uploader" id="imageUploader">
                    <i class="fa-solid fa-cloud-arrow-up"></i>
                    <p>이미지를 드래그하거나<br>클릭해서 업로드하세요</p>
                </div>
                <input type="file" id="fileInput" name="files" multiple hidden>
                <div id="imagePreview" style="margin-top: 15px;"></div>
            </div>
        </div>
    </form> 

    <div class="form-actions">
        <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
        <button type="submit" form="review-form" class="btn btn-primary">등록하기</button>
    </div>
</div>

<div id="courseModal" class="modal-overlay">
    <div class="modal-content">
        <h2>코스 선택</h2>
        <div id="courseList" class="course-list">
            </div>
        <button type="button" class="btn-close-modal">닫기</button>
    </div>
</div>
<script>
document.addEventListener('DOMContentLoaded', () => {
    
    console.log('DEBUG: DOM이 로드되었습니다. 스크립트를 시작합니다.');

    // --- 1. 코스 선택 모달 관련 ---
    const btn = document.getElementById('selectRoadBtn');
    const roadNoInput = document.getElementById('roadNo');
    const selected = document.getElementById('selectedCourseName');
    
    const modal = document.getElementById('courseModal');
    const courseListContainer = document.getElementById('courseList');
    const closeModalBtn = modal.querySelector('.btn-close-modal');

    // DEBUG: 주요 요소들이 제대로 찾아졌는지 확인
    if (!btn) console.error('DEBUG ERROR: "selectRoadBtn" 버튼을 찾지 못했습니다!');
    if (!modal) console.error('DEBUG ERROR: "courseModal" 요소를 찾지 못했습니다!');
    if (!courseListContainer) console.error('DEBUG ERROR: "courseList" 요소를 찾지 못했습니다!');


    // [코스 선택하기] 버튼 클릭 시
    btn.addEventListener('click', async () => {
        
        console.log('DEBUG: [1] 버튼이 클릭되었습니다.');
        
        /* modal.style.display = 'flex';
        console.log('DEBUG: [2] 모달을 열었습니다.'); */

        try {
            console.log('DEBUG: [3] fetch를 시도합니다: /review/trip/list');
            const res = await fetch('/review/trip/list');
            console.log('DEBUG: [4] fetch 응답을 받았습니다:', res);
            if (!res.ok) {
                console.error('DEBUG ERROR: fetch 응답이 "ok"가 아닙니다.', res.status);
                throw new Error('서버 통신 실패 (상태: ' + res.status + ')');
            }
            
            const list = await res.json();
            console.log('DEBUG: [5] JSON 파싱 완료:', list);

            if (!Array.isArray(list) || list.length === 0) {
                alert('선택 가능한 코스가 없습니다.');
                console.warn('DEBUG: [6] 받아온 list가 비어있거나 배열이 아닙니다.');
                return;
            }

            // 기존 목록 비우기
            courseListContainer.innerHTML = '';
            
            // 목록 동적 생성
            list.forEach(r => {
                const name = (r.roadName && r.roadName.trim()) ? r.roadName.trim() : '이름 없음';
                const item = document.createElement('div');
                item.className = 'course-item';
                item.textContent = r.roadNo + ' : ' + r.roadName;

                item.dataset.roadNo = r.roadNo;
                item.dataset.roadName = name;
                courseListContainer.appendChild(item);
            });
            modal.style.display = 'flex';
            console.log('DEBUG: [4] 모달 표시 완료, 항목 개수:', list.length);

        } catch (err) {
            console.error('DEBUG ERROR: [CATCH] fetch 또는 이후 과정에서 오류 발생:', err);
            alert('코스 목록을 불러오지 못했습니다. (콘솔창을 확인해주세요)');
        }
    });

    // 모달 닫기 (닫기 버튼 클릭)
    closeModalBtn.addEventListener('click', () => {
        console.log('DEBUG: 모달 닫기 버튼 클릭');
        modal.style.display = 'none';
    });

    // 모달 닫기 (배경 클릭)
    modal.addEventListener('click', (e) => {
        if (e.target === modal) {
            console.log('DEBUG: 모달 배경 클릭');
            modal.style.display = 'none';
        }
    });

    // 코스 항목 선택 시 (이벤트 위임)
    courseListContainer.addEventListener('click', (e) => {
        const item = e.target.closest('.course-item');
        if (item) {
            roadNoInput.value = item.dataset.roadNo;
            selected.textContent = '선택된 코스: ' + item.dataset.roadName;
            console.log('DEBUG: 코스 선택 완료. roadNo:', roadNoInput.value);
            modal.style.display = 'none';
        }
    });

    // --- 2. 별점 스크립트 (기존과 동일) ---
    const stars = document.querySelectorAll('.rating .stars .fa-star');
    const ratingInput = document.getElementById('reviewRating');
    stars.forEach(star => {
        star.addEventListener('mouseover', () => {
            resetStars();
            highlightStars(star.dataset.value);
        });
        star.addEventListener('mouseout', () => {
            resetStars();
            highlightStars(ratingInput.value);
        });
        star.addEventListener('click', () => {
            ratingInput.value = star.dataset.value;
            highlightStars(ratingInput.value);
        });
    });
    function highlightStars(rating) {
        for (let i = 0; i < rating; i++) stars[i]?.classList.add('selected');
    }
    function resetStars() { stars.forEach(s => s.classList.remove('selected')); }

    // --- 3. 이미지 업로드 스크립트 (기존과 동일) ---
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
        showPreviews(fileInput.files);
    });
    fileInput.addEventListener('change', () => showPreviews(fileInput.files));

    function showPreviews(files) {
        preview.innerHTML = '';
        if (files.length > 0) {
            uploader.querySelector('p').textContent = `${files.length}개의 파일 선택됨`;
            for (const f of files) {
                if (f.type.startsWith('image/')) {
                    const reader = new FileReader();
                    reader.onload = e => {
                        const img = document.createElement('img');
                        img.src = e.target.result;
                        img.style.maxWidth = '80px';
                        img.style.maxHeight = '80px';
                        img.style.margin = '5px';
                        preview.appendChild(img);
                    };
                    reader.readAsDataURL(f);
                }
            }
        } else {
            uploader.querySelector('p').innerHTML = '이미지를 드래그하거나<br>클릭해서 업로드하세요';
        }
    }
});
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
</body>
</html>