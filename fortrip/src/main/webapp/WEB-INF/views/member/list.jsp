<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 찜 목록</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<link rel="icon" type="image/png" href="/resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="/resources/css/member/list.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="container">
    <!-- 사이드바 -->
    <aside class="sidebar">
        <a href="/member/profile">내 프로필</a>
        <a href="/member/myBoard">내 게시글</a>
        <a href="/member/list" class="active">찜 목록</a>
        <a href="/member/recent">최근 본 코스</a>
        <a href="/member/update">개인 정보 수정</a>
        <a href="/member/delete">회원탈퇴</a>
    </aside>

    <!-- 메인 컨텐츠 -->
    <main class="main-content">
        <div class="header-section">
            <div class="header-left">
                <h1 class="page-title">찜 목록</h1>
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

        <!-- 필터 섹션 -->
        <div class="filter-section">
            <div class="filter-left">
                <button class="filter-btn active" data-type="">
                    전체 <span class="count" id="totalCount">0</span>
                </button>
                <button class="filter-btn" data-type="community">
                    커뮤니티 <span class="count" id="communityCount">0</span>
                </button>
                <button class="filter-btn" data-type="review">
                    리뷰 <span class="count" id="reviewCount">0</span>
                </button>
            </div>
            
            <div class="filter-right">
                <select id="regionFilter" class="region-select">
                    <option value="">전체보기</option>
                    <option value="서울">서울</option>
                    <option value="부산">부산</option>
                    <option value="인천">인천</option>
                    <option value="대구">대구</option>
                    <option value="대전">대전</option>
                    <option value="광주">광주</option>
                    <option value="울산">울산</option>
                    <option value="세종">세종</option>
                    <option value="경기">경기</option>
                    <option value="강원">강원</option>
                    <option value="충북">충북</option>
                    <option value="충남">충남</option>
                    <option value="전북">전북</option>
                    <option value="전남">전남</option>
                    <option value="경북">경북</option>
                    <option value="경남">경남</option>
                    <option value="제주">제주</option>
                </select>
            </div>
        </div>

        <!-- 찜 목록 그리드 -->
        <div class="liked-grid">
            <c:forEach var="item" items="${likedList}">
                <div class="liked-card" data-id="${item.targetNo}" data-type="${item.targetType}">
                    <!-- 체크박스 -->
                    <input type="checkbox" class="selectCheckbox" style="display:none;">
                    
                    <!-- 썸네일 -->
                    <div class="card-thumbnail ${empty item.thumbnailPath ? 'no-image' : ''} ${item.targetType}">
                        <c:choose>
                            <c:when test="${not empty item.thumbnailPath}">
                                <img src="${item.thumbnailPath}" alt="${item.title}">
                            </c:when>
                            <c:otherwise>
                                <i class="fa-regular fa-image fa-3x" style="color:rgba(255,255,255,0.8);"></i>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- 카드 본문 -->
                    <div class="card-body">
                        <div class="card-category ${item.targetType}">
                            ${item.targetType == 'community' ? '커뮤니티' : '리뷰'}
                        </div>
                        <h3 class="card-title">${item.title}</h3>
                        <div class="card-meta">
                            <span class="meta-item">
                                <i class="fa-regular fa-clock"></i>
                                <fmt:formatDate value="${item.bookmarkDate}" pattern="yyyy.MM.dd"/>
                            </span>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty likedList}">
                <div class="empty-state">
                    <i class="fa-regular fa-heart fa-4x"></i>
                    <p>찜한 게시글이 없습니다.</p>
                    <a href="/board/free/list" class="btn-primary">게시글 둘러보기</a>
                </div>
            </c:if>
        </div>
    </main>
</div>

	<script>
		let editMode = false;
		const editBtn = document.getElementById("editBtn");
		const editControls = document.getElementById("editControls");
		const cancelBtn = document.getElementById("cancelBtn");
		const selectDeleteBtn = document.getElementById("selectDeleteBtn");
		const deleteAllBtn = document.getElementById("deleteAllBtn");
		const likedCards = document.querySelectorAll(".liked-card");
		const filterBtns = document.querySelectorAll(".filter-btn");
		const regionFilter = document.getElementById("regionFilter");
		
		// 카운트 업데이트 함수
		function updateCounts() {
		    const allCards = document.querySelectorAll('.liked-card');
		    const communityCards = document.querySelectorAll('.liked-card[data-type="community"]');
		    const reviewCards = document.querySelectorAll('.liked-card[data-type="review"]');
		    
		    document.getElementById('totalCount').textContent = allCards.length;
		    document.getElementById('communityCount').textContent = communityCards.length;
		    document.getElementById('reviewCount').textContent = reviewCards.length;
		    
		    console.log('전체:', allCards.length, '커뮤니티:', communityCards.length, '리뷰:', reviewCards.length);
		}
		
		// 페이지 로드 시 카운트 업데이트
		updateCounts();
		
		// 편집 모드
		editBtn.addEventListener("click", () => {
		    editMode = true;
		    editBtn.style.display = "none";
		    editControls.style.display = "flex";
		    likedCards.forEach(card => {
		        card.querySelector(".selectCheckbox").style.display = "block";
		        card.style.cursor = "default";
		    });
		});
		
		cancelBtn.addEventListener("click", () => {
		    editMode = false;
		    editBtn.style.display = "inline-flex";
		    editControls.style.display = "none";
		    likedCards.forEach(card => {
		        const checkbox = card.querySelector(".selectCheckbox");
		        checkbox.style.display = "none";
		        checkbox.checked = false;
		        card.style.cursor = "pointer";
		    });
		});
		
		// 카드 클릭 이벤트
		likedCards.forEach(card => {
		    card.addEventListener("click", (e) => {
		        // 체크박스 클릭 시 이벤트 전파 중단
		        if (e.target.classList.contains("selectCheckbox")) {
		            e.stopPropagation();
		            return;
		        }
		
		        if (editMode) {
		            const checkbox = card.querySelector(".selectCheckbox");
		            checkbox.checked = !checkbox.checked;
		        } else {
		            const targetType = card.dataset.type;
		            const targetNo = card.dataset.id;
		            const url = targetType === 'community' 
		                ? '/board/free/detail?postNo=' + targetNo
		                : '/board/review/detail?reviewNo=' + targetNo;
		            window.location.href = url;
		        }
		    });
		});
		
		// 타입 필터
		filterBtns.forEach(btn => {
		    btn.addEventListener("click", () => {
		        filterBtns.forEach(b => b.classList.remove("active"));
		        btn.classList.add("active");
		        filterCards();
		    });
		});
		
		// 지역 필터 (형식용)
		regionFilter.addEventListener("change", () => {
		    filterCards();
		});
		
		function filterCards() {
		    const type = document.querySelector(".filter-btn.active").dataset.type;
		    const region = regionFilter.value;
		    
		    likedCards.forEach(card => {
		        const matchType = !type || card.dataset.type === type;
		        // 지역 필터는 형식용이므로 항상 true
		        const matchRegion = true;
		        
		        card.style.display = (matchType && matchRegion) ? "block" : "none";
		    });
		}
		
		// 선택 삭제
		selectDeleteBtn.addEventListener("click", () => {
		    const selectedIds = Array.from(document.querySelectorAll(".selectCheckbox:checked"))
		        .map(cb => parseInt(cb.closest(".liked-card").dataset.id));
		    
		    if (selectedIds.length === 0) {
		        alert("선택된 항목이 없습니다.");
		        return;
		    }
		
		    if (!confirm('선택한 ' + selectedIds.length + '개 항목을 삭제하시겠습니까?')) return;
		
		    fetch('/member/deleteLiked', {
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
		    if (!confirm("정말 모든 찜 항목을 삭제하시겠습니까?")) return;
		    
		    fetch('/member/deleteAllLiked', {
		        method: 'POST'
		    })
		    .then(res => {
		        if (res.ok) {
		            alert("모든 찜 목록이 삭제되었습니다.");
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