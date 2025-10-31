<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 최근 본 코스</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="icon" type="image/png" href="/resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="/resources/css/member/recent.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="container">
    <!-- 사이드바 -->
    <aside class="sidebar">
        <a href="/member/profile">내 프로필</a>
        <a href="/member/myBoard">내 게시글</a>
        <a href="/member/list">찜 목록</a>
        <a href="/member/recent" class="active">최근 본 코스</a>
        <a href="/member/update">개인 정보 수정</a>
        <a href="/member/delete">회원탈퇴</a>
    </aside>

    <!-- 메인 컨텐츠 -->
    <main class="main-content">
        <div class="header-section">
            <div class="header-left">
                <h1 class="page-title">최근 본 코스</h1>
            </div>
            
            <div class="header-right">
                <button id="editBtn" class="btn-edit">
                    <i class="fa-solid fa-pen-to-square"></i> 편집
                </button>
                
                <div id="editControls" class="edit-controls" style="display:none;">
                    <button id="selectDeleteBtn" class="btn-danger">
                        <i class="fa-solid fa-trash"></i> 선택 삭제
                    </button>
                    <button id="deleteAllBtn" class="btn-danger-outline">
                        <i class="fa-solid fa-trash-can"></i> 전체 삭제
                    </button>
                    <button id="cancelBtn" class="btn-cancel">
                        <i class="fa-solid fa-xmark"></i> 취소
                    </button>
                </div>
            </div>
        </div>

        <!-- 최근 본 코스 리스트 -->
        <div class="recent-list">
            <c:forEach var="trip" items="${recentList}">
                <div class="trip-card" data-id="${trip.courseId}">
                    <!-- 체크박스 -->
                    <input type="checkbox" class="selectCheckbox" style="display:none;">
                    
                    <div class="trip-thumbnail ${empty trip.courseId ? 'no-image' : ''}">
                        <c:choose>
                            <c:when test="${not empty trip.courseId}">
                                <img src="/resources/img/course/${trip.courseId}.jpg"
                                     alt="${trip.roadName}"
                                     onerror="this.onerror=null; this.parentElement.innerHTML='<i class=\'fa-regular fa-image fa-3x\'></i>';" />
                            </c:when>
                            <c:otherwise>
                                <i class="fa-regular fa-image fa-3x"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="trip-info">
                        <h3 class="trip-title">${trip.roadName}</h3>
                        <p class="trip-location">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor">
                                <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                                <circle cx="12" cy="10" r="3"/>
                            </svg>
                            ${trip.roadLocation}
                        </p>
                        <p class="trip-cost">${trip.roadCost}</p>
                        <p class="trip-date">
                            조회: <fmt:formatDate value="${trip.viewDate}" pattern="yyyy-MM-dd HH:mm" />
                        </p>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty recentList}">
                <div class="empty-state">
                    <i class="fa-regular fa-eye fa-4x"></i>
                    <p>최근 본 코스가 없습니다.</p>
                    <a href="/" class="btn-primary">코스 둘러보기</a>
                </div>
            </c:if>
        </div>

        <!-- 페이지네이션 -->
        <c:if test="${not empty recentList}">
            <div class="pagination">
                <c:if test="${page > 1}">
                    <a href="?page=${page - 1}" class="page-btn">이전</a>
                </c:if>
                
                <span class="current-page">${page}</span>
                
                <c:if test="${recentList.size() == 20}">
                    <a href="?page=${page + 1}" class="page-btn">다음</a>
                </c:if>
            </div>
        </c:if>
    </main>
</div>

<script>
let editMode = false;
const editBtn = document.getElementById("editBtn");
const editControls = document.getElementById("editControls");
const cancelBtn = document.getElementById("cancelBtn");
const selectDeleteBtn = document.getElementById("selectDeleteBtn");
const deleteAllBtn = document.getElementById("deleteAllBtn");
const tripCards = document.querySelectorAll(".trip-card");

// 편집 모드
editBtn.addEventListener("click", () => {
    editMode = true;
    editBtn.style.display = "none";
    editControls.style.display = "flex";
    tripCards.forEach(card => {
        card.querySelector(".selectCheckbox").style.display = "block";
        card.style.cursor = "default";
    });
});

cancelBtn.addEventListener("click", () => {
    editMode = false;
    editBtn.style.display = "inline-flex";
    editControls.style.display = "none";
    tripCards.forEach(card => {
        const checkbox = card.querySelector(".selectCheckbox");
        checkbox.style.display = "none";
        checkbox.checked = false;
        card.style.cursor = "pointer";
    });
});

// 카드 클릭 이벤트
tripCards.forEach(card => {
    card.addEventListener("click", (e) => {
        if (e.target.classList.contains("selectCheckbox")) {
            e.stopPropagation();
            return;
        }

        if (editMode) {
            const checkbox = card.querySelector(".selectCheckbox");
            checkbox.checked = !checkbox.checked;
        } else {
            const courseId = card.dataset.id;
            window.location.href = '/trip/coursedetail/' + courseId;
        }
    });
});

// 선택 삭제
selectDeleteBtn.addEventListener("click", () => {
    const selectedIds = Array.from(document.querySelectorAll(".selectCheckbox:checked"))
        .map(cb => cb.closest(".trip-card").dataset.id);
    
    if (selectedIds.length === 0) {
        alert("선택된 항목이 없습니다.");
        return;
    }

    if (!confirm('선택한 ' + selectedIds.length + '개 항목을 삭제하시겠습니까?')) return;

    // TODO: 서버에 삭제 요청
    fetch('/member/deleteRecent', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify(selectedIds)
    })
    .then(res => {
        if (res.ok) {
            alert("삭제되었습니다.");
            location.reload();
        }
    })
    .catch(err => {
        console.error(err);
        alert("삭제 중 오류가 발생했습니다.");
    });
});

// 전체 삭제
deleteAllBtn.addEventListener("click", () => {
    if (!confirm("정말 모든 기록을 삭제하시겠습니까?")) return;
    
    // TODO: 서버에 전체 삭제 요청
    fetch('/member/deleteAllRecent', {
        method: 'POST'
    })
    .then(res => {
        if (res.ok) {
            alert("모든 기록이 삭제되었습니다.");
            location.reload();
        }
    })
    .catch(err => {
        console.error(err);
        alert("삭제 중 오류가 발생했습니다.");
    });
});
</script>
</body>
</html>