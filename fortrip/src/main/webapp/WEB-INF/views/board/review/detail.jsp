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
        .reaction-buttons .btn { display: flex; align-items: center; gap: 6px; background-color: #f1f3f5; border: 1px solid #dee2e6; padding: 8px 15px; border-radius: 20px; cursor: pointer; font-size: 14px; transition: all 0.2s ease; }
        .reaction-buttons .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .reaction-buttons .btn.liked { background-color: #ffe0e0; border-color: #ffc2c2; color: #dc3545; font-weight: bold; }
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
                            <i class="fa-solid fa-star" style="${i <= review.reviewRating ? '' : 'color:#ddd;'}"></i>
                        </c:forEach>
                    </span>
                    <div class="post-meta">
                        <span>${review.writer}</span>
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
                    <button class="btn" id="likeBtn" data-board-type="REVIEW" data-board-no="${review.reviewNo}">
                            <i class="fa-regular fa-heart"></i> <span id="likeCount">${likeCount}</span>
                        </button>
                        <button class="btn" id="bookmarkBtn" data-target-type="REVIEW" data-target-no="${review.reviewNo}">
                            <i class="fa-regular fa-bookmark"></i> 북마크
                        </button>
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
				      <textarea name="commentContent" placeholder="댓글을 입력해주세요..."></textarea>
				      <div class="comment-form-actions">
				          <button type="button" class="btn btn-submit">작성</button>
				      </div>
				  </div>
				
				  <ul class="comment-list" id="commentListArea">
				      <p style="text-align:center; color:#888; padding:20px 0;">댓글을 불러오는 중...</p>
				  </ul>
			</section>
            
            <div class="bottom-actions">
                <a href="/board/review/list" class="btn-list">게시글 목록</a>
            </div>
        </main>
    </div>
    <script>
	const isUserLiked = ${isLiked != null ? isLiked : false}; // Controller 값이 null일 경우 false 기본값
	console.log("isLiked from server:", isUserLiked); // 콘솔에 값 출력해보기
	
	document.addEventListener('DOMContentLoaded', () => {
		
		 const boardNo = "${review.reviewNo}";
		  const boardType = "REVIEW";

		  console.log("✅ boardNo:", boardNo);
		  console.log("✅ boardType:", boardType);

		  if (!boardNo || boardNo === "null" || boardNo.trim() === "") {
		    console.error("❌ boardNo 비어 있음");
		    return;
		  }
		 // ===== 댓글 목록 불러오기 =====
		  function loadComments() {
		    const boardNo = "${review.reviewNo}";
		    const boardType = "REVIEW";
		    
		    if (!boardNo || boardNo.trim() === "") {
		        console.error("boardNo 값이 비어 있음:", boardNo);
		        return;
		      }   

		    fetch(`/board/comment/list?boardNo=${boardNo}&boardType=${boardType}`)
		      .then(res => res.json())
		      .then(commentList => {
		        const listArea = document.getElementById("commentListArea");
		        listArea.innerHTML = ""; // 초기화

		        if (commentList.length === 0) {
		          listArea.innerHTML = `<p style="text-align:center; color:#888; padding:20px 0;">작성된 댓글이 없습니다.</p>`;
		          return;
		        }

		        commentList.forEach(c => {
		        	  const li = document.createElement("li");
		        	  li.classList.add("comment-item");

		        	  li.innerHTML = `
		        	    <p class="comment-author">${c.writerNickname}</p>
		        	    <p class="comment-content">${c.commentContent}</p>
		        	  `;

		        	  if (c.isOwner) {
		        	    const actionsDiv = document.createElement("div");
		        	    actionsDiv.classList.add("comment-actions");
		        	    actionsDiv.style.textAlign = "right";
		        	    actionsDiv.style.fontSize = "12px";
		        	    actionsDiv.style.marginTop = "10px";

		        	    const deleteLink = document.createElement("a");
		        	    deleteLink.href = "#";
		        	    deleteLink.classList.add("delete-comment");
		        	    deleteLink.dataset.commentNo = c.commentNo;
		        	    deleteLink.textContent = "삭제";

		        	    actionsDiv.appendChild(deleteLink);
		        	    li.appendChild(actionsDiv);
		        	  }

		        	  listArea.appendChild(li);
		        	});

		        // 삭제 버튼 이벤트 등록
		        document.querySelectorAll(".delete-comment").forEach(btn => {
		          btn.addEventListener("click", e => {
		            e.preventDefault();
		            const commentNo = btn.dataset.commentNo;
		            if (confirm("정말 삭제하시겠습니까?")) {
		              fetch(`/board/comment/delete?commentNo=${commentNo}`, { method: "POST" })
		                .then(res => res.json())
		                .then(result => {
		                  if (result > 0) {
		                    loadComments();
		                  } else {
		                    alert("댓글 삭제에 실패했습니다.");
		                  }
		                })
		                .catch(() => alert("댓글 삭제 중 오류가 발생했습니다."));
		            }
		          });
		        });
		      })
		      .catch(() => alert("댓글 불러오기 중 오류가 발생했습니다."));
		  }

		  // ===== 댓글 등록 =====
		  const submitBtn = document.querySelector(".btn-submit");
		  submitBtn.addEventListener("click", e => {
		    e.preventDefault();
		    const content = document.querySelector("textarea[name='commentContent']").value.trim();
		    if (content === "") {
		      alert("댓글 내용을 입력하세요.");
		      return;
		    }

		    const boardNo = "${review.reviewNo}";
		    const boardType = "REVIEW";

		    fetch("/board/comment/insert", {
		      method: "POST",
		      headers: { "Content-Type": "application/json" },
		      body: JSON.stringify({ boardNo, boardType, commentContent: content })
		    })
		      .then(res => res.json())
		      .then(result => {
		        if (result > 0) {
		          document.querySelector("textarea[name='commentContent']").value = "";
		          loadComments();
		        } else {
		          alert("댓글 등록에 실패했습니다.");
		        }
		      })
		      .catch(() => alert("댓글 등록 중 오류가 발생했습니다."));
		  });

		  // 초기 로드
		  loadComments();
		
	    // ===== 좋아요 기능 =====
	    const likeBtn = document.getElementById('likeBtn');
	    
	    if (likeBtn) {
	    	const likeCountSpan = document.getElementById('likeCount');

	        const isUserLiked = ${isLiked != null ? isLiked : false};   // JS boolean로 렌더링
	        if (isUserLiked) {
	          likeBtn.classList.add('liked');
	          likeBtn.querySelector('i').classList.replace('fa-regular', 'fa-solid');
	        }
	
	        likeBtn.addEventListener('click', () => {
	            const isLoggedIn = "${sessionScope.loginMember != null}";
	            if (isLoggedIn !== "true") {
	                alert('로그인 후 이용 가능합니다.');
	                location.href = '<c:url value="/member/login"/>';
	                return;
	            }
	
	            const boardType = likeBtn.dataset.boardType.trim();;
	            const boardNo = likeBtn.dataset.boardNo.trim();;
	          
	            console.log('boardType=', likeBtn.dataset.boardType, 'boardNo=', likeBtn.dataset.boardNo);
	
	            fetch('<c:url value="/board/like/toggle"/>', {
	                method: 'POST',
	                headers: { 'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8' },
	                body: new URLSearchParams({
	                    boardType: boardType,
	                    boardNo: boardNo
	                })
	            })
	            .then(res => res.json())
	            .then(data => {
	                likeCountSpan.textContent = data.likeCount;
	                const icon = likeBtn.querySelector('i');
	                if (data.isLiked) {
	                    likeBtn.classList.add('liked');
	                    icon.classList.replace('fa-regular', 'fa-solid');
	                } else {
	                    likeBtn.classList.remove('liked');
	                    icon.classList.replace('fa-solid', 'fa-regular');
	                } 
	            })
	            .catch(err => console.error('좋아요 오류:', err));
	        });
	    }
	});

</script>
</body>
</html>