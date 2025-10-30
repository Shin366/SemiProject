<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 찜 목록</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="../../../resources/css/member/list.css">
</head>
<body>
	<div class="container">

    <div class="list-header">
        <h2>찜 목록</h2>
        <div class="sidebar">
            <ul>
                <li><a href="/member/profile">내 프로필</a></li>
                <li><a href="/member/myBoard" class="active">내 게시글</a></li>
                <li><a href="/member/list">찜 목록</a></li>
                <li><a href="/member/recent">최근 본 코스</a></li>
                <li><a href="/member/update">개인 정보 수정</a></li>
                <li><a href="/member/delete">회원탈퇴</a></li>
            </ul>
        </div>
        <div class="list-controls">
            <!-- 왼쪽 상단: 지역 select -->
            <select id="regionFilter">
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

            <!-- 오른쪽 상단: 코스/커뮤니티 구분 -->
            <div class="type-filter">
                <button class="filter-btn active" data-type="">전체</button>
                <button class="filter-btn" data-type="course">코스</button>
                <button class="filter-btn" data-type="community">커뮤니티</button>
            </div>

            <!-- 편집 버튼 -->
            <button id="editBtn">편집</button>

            <!-- 편집 상태 버튼 -->
            <div id="editControls" style="display:none;">
                <button id="selectDeleteBtn">선택 삭제</button>
                <button id="deleteAllBtn">전체 삭제</button>
                <button id="cancelBtn">취소</button>
            </div>
        </div>
    </div>

    <div class="liked-grid">
        <c:forEach var="item" items="${likedList}">
            <div class="liked-card" data-id="${item.targetNo}" data-type="${item.targetType}" data-region="${item.region}">
                <input type="checkbox" class="selectCheckbox" style="display:none;">
                <div class="liked-title">${item.title}</div>
                <div class="liked-meta">
                    <span>게시판 종류: ${item.targetType}</span>
                    <span>조회수: ${item.viewCount}</span>
                    <span>좋아요: ${item.likeCount}</span>
                    <span>등록일: <fmt:formatDate value="${item.createDate}" pattern="yyyy-MM-dd"/></span>
                </div>
                <a href="/board/${item.targetType}/detail?boardNo=${item.targetNo}" class="btn-detail">보러가기</a>
            </div>
        </c:forEach>
    </div>

</div>
</body>
	<script>
	let editMode = false;
	const editBtn = document.getElementById("editBtn");
	const editControls = document.getElementById("editControls");
	const cancelBtn = document.getElementById("cancelBtn");
	const selectDeleteBtn = document.getElementById("selectDeleteBtn");
	const deleteAllBtn = document.getElementById("deleteAllBtn");
	const likedCards = document.querySelectorAll(".liked-card");
	const regionFilter = document.getElementById("regionFilter");
	const filterBtns = document.querySelectorAll(".filter-btn");

	editBtn.addEventListener("click", () => {
	    editMode = true;
	    editBtn.style.display = "none";
	    editControls.style.display = "block";
	    likedCards.forEach(card => card.querySelector(".selectCheckbox").style.display="block");
	});

	cancelBtn.addEventListener("click", () => {
	    editMode = false;
	    editBtn.style.display = "block";
	    editControls.style.display = "none";
	    likedCards.forEach(card => card.querySelector(".selectCheckbox").checked=false);
	});

	likedCards.forEach(card => {
	    card.addEventListener("click", (e) => {
	        if(editMode){
	            const checkbox = card.querySelector(".selectCheckbox");
	            checkbox.checked = !checkbox.checked;
	            e.preventDefault();
	        }
	    });
	});

	regionFilter.addEventListener("change", filterCards);
	filterBtns.forEach(btn => {
	    btn.addEventListener("click", () => {
	        filterBtns.forEach(b => b.classList.remove("active"));
	        btn.classList.add("active");
	        filterCards();
	    });
	});

	function filterCards(){
	    const region = regionFilter.value;
	    const type = document.querySelector(".filter-btn.active").dataset.type;
	    likedCards.forEach(card => {
	        const matchRegion = !region || card.dataset.region === region;
	        const matchType = !type || card.dataset.type === type;
	        card.style.display = (matchRegion && matchType) ? "block" : "none";
	    });
	}

	// AJAX 삭제
	selectDeleteBtn.addEventListener("click", () => {
	    const selectedIds = Array.from(document.querySelectorAll(".selectCheckbox:checked"))
	        .map(cb => cb.closest(".liked-card").dataset.id);
	    if(selectedIds.length === 0) { alert("선택된 항목이 없습니다."); return; }
	    fetch('/member/deleteLiked', {
	        method:'POST',
	        headers:{'Content-Type':'application/json'},
	        body:JSON.stringify(selectedIds)
	    }).then(res=>location.reload());
	});

	deleteAllBtn.addEventListener("click", () => {
	    if(confirm("정말 모든 찜 항목을 삭제하시겠습니까?")){
	        fetch('/member/deleteAllLiked',{method:'POST'}).then(res=>location.reload());
	    }
	});
	</script>
</html>