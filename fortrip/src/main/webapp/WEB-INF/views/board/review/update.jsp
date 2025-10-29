<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>코스 리뷰 - 수정</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
    <link rel="stylesheet" href="<c:url value='/resources/css/common/header.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/board/review/update.css'/>">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <aside class="sidebar">
            <ul>
                <li><a href="<c:url value='/board/free/list'/>">자유 소통</a></li>
                <li><a href="<c:url value='/board/review/list'/>" class="active">코스 리뷰</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <h1 class="page-title">코스 리뷰 수정</h1>

            <%-- form ID 확인 --%>
            <form id="updateForm" action="/board/review/update" method="post" enctype="multipart/form-data">
                <%-- 리뷰 번호 hidden input --%>
                <input type="hidden" name="reviewNo" value="${review.reviewNo}">

                <article class="review-article">
                    <div class="form-group">
                        <label for="reviewTitle">제목</label>
                        <%-- value 속성에 DTO 필드명 사용 --%>
                        <input type="text" id="reviewTitle" name="reviewTitle" class="title-input" value="${review.reviewTitle}" required>
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
                        <%-- value 속성에 DTO 필드명 사용 --%>
                        <input type="hidden" id="reviewRating" name="reviewRating" value="${review.reviewRating}" required>
                    </div>

                    <div class="course-link-wrapper">
                         <div class="course-info">
                            <%-- 코스 이름 대신 코스 번호(roadNo) 표시 (Controller에서 이름 조회 안 했을 경우) --%>
                            <i class="fa-solid fa-route"></i>리뷰 대상 코스 번호: ${review.roadNo}
                        </div>
                        <%-- 수정 페이지에서는 코스 변경 불가하도록 hidden 처리 권장 --%>
                        <input type="hidden" name="roadNo" value="${review.roadNo}">
                        <input type="hidden" name="reviewerType" value="${review.reviewerType}">
                    </div>

                    <div class="form-group">
                        <label for="reviewSubtitle">부제목</label>
                        <%-- value 속성에 DTO 필드명 사용 --%>
                        <input type="text" id="reviewSubtitle" name="reviewSubtitle" value="${review.reviewSubtitle}">
                    </div>

                    <div class="form-group">
                        <label for="reviewContent">본문</label>
                        <%-- textarea 내용은 태그 사이에 DTO 필드명 사용 --%>
                        <textarea id="reviewContent" name="reviewContent" required>${review.reviewContent}</textarea>
                    </div>

                    <%-- === 파일 첨부 영역 수정 === --%>
                    <div class="form-group">
                        <label>첨부 파일</label>
                        <%-- 기존 파일 목록 및 삭제 체크박스 --%>
                        <div class="existing-files">
                            <ul>
                                <c:forEach var="attach" items="${attachmentList}"> <%-- Controller에서 attachmentList 전달 가정 --%>
                                    <li>
                                        <span>${attach.originalName}</span>
                                        <label>
                                            <input type="checkbox" name="deletedFiles" value="${attach.attachNo}"> 삭제
                                        </label>
                                    </li>
                                </c:forEach>
                                <c:if test="${empty attachmentList}">
                                    <li>첨부된 파일이 없습니다.</li>
                                </c:if>
                            </ul>
                        </div>
                        <%-- 새 파일 첨부 input --%>
                        <div class="new-file-input">
                            <label for="reloadFiles">새 파일 추가:</label>
                            <%-- name을 reloadFiles로 변경, multiple 추가 --%>
                            <input type="file" id="reloadFiles" name="reloadFiles" multiple>
                        </div>
                    </div>
                    <%-- === 파일 첨부 영역 수정 끝 === --%>

                </article>
            </form>

            <div class="bottom-actions">
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                <%-- submit 버튼의 form 속성 수정 --%>
                <button type="submit" form="updateForm" class="btn btn-submit">수정 완료</button>
            </div>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const stars = document.querySelectorAll('.rating-input .stars .fa-star');
            const ratingInput = document.getElementById('reviewRating');

            // 페이지 로드 시 기존 별점을 UI에 표시
            const initialRating = ratingInput.value;
            if (initialRating && initialRating > 0) { // Check if initialRating is valid
                updateStars(initialRating);
            }

            stars.forEach(star => {
                star.addEventListener('click', function() {
                    const rating = this.dataset.value;
                    ratingInput.value = rating;
                    updateStars(rating);
                });
                // Mouseover/Mouseout 이벤트 추가 (선택 사항)
                star.addEventListener('mouseover', () => highlightStars(star.dataset.value));
                star.addEventListener('mouseout', () => updateStars(ratingInput.value));
            });

            function highlightStars(rating) {
                 stars.forEach(s => {
                     s.classList.remove('selected');
                     if (s.dataset.value <= rating) {
                         s.classList.add('selected');
                     }
                 });
            }
            function updateStars(rating) {
                 stars.forEach(s => {
                     s.classList.toggle('selected', s.dataset.value <= rating);
                 });
            }
        });
    </script>
</body>
</html>