<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>코스 리뷰</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
    <link rel="stylesheet" href="<c:url value='/resources/css/common/header.css'/>">
    <link rel="stylesheet" href="<c:url value='/resources/css/board/review/detail.css'/>">
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
                    <button class="btn" id="reportBtn">신고</button>

                </div>
                <div class="social-share">
                    <a href="#"><i class="fab fa-facebook-square"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </footer>
            
            <!-- 댓글 영역 -->
			<section class="comments-section">
			  <div class="comment-form">
			    <input type="hidden" id="boardNo" value="${review.reviewNo}">
			    <input type="hidden" id="boardType" value="REVIEW">
			
			    <textarea id="commentContent" name="commentContent" placeholder="댓글을 입력해주세요..."></textarea>
			    <div style="text-align: right; margin-top: 10px;">
			      <button id="commentSubmitBtn" type="button" class="btn btn-submit">등록</button>
			    </div>
			  </div>
			
			  <!-- 댓글 목록 -->
			  <div id="commentListArea" class="comment-list">
			    <c:forEach var="comment" items="${commentList}">
			      <div class="comment-card" data-comment-no="${comment.commentNo}">
			        <div class="comment-header">
			          <span class="comment-author">${comment.writerNickname}</span>
			          <span class="comment-date">
			            <fmt:formatDate value="${comment.commentDate}" pattern="yyyy.MM.dd HH:mm"/>
			          </span>
			        </div>
			
			        <div class="comment-content">${comment.commentContent}</div>
			
			        <c:if test="${sessionScope.loginMember.memberNo == comment.memberNo}">
			          <div class="comment-actions">
			            <button type="button" class="edit-btn">수정</button>
			            <button type="button" class="delete-btn">삭제</button>
			          </div>
			        </c:if>
			      </div>
			    </c:forEach>
			
			    <c:if test="${empty commentList}">
			      <p style="text-align:center; color:#888; padding: 30px 0;">작성된 댓글이 없습니다.</p>
			    </c:if>
			  </div>
			</section>
            
            <div class="bottom-actions">
                <div>
                    <c:if test="${sessionScope.loginMember.memberNo == review.memberNo}">
                        <a href="<c:url value='/board/review/update?reviewNo=${review.reviewNo}'/>" class="btn">수정</a>
                        <a href="<c:url value='/board/review/delete?reviewNo=${review.reviewNo}'/>" class="btn">삭제</a>
                    </c:if>
                </div>
                <a href="<c:url value='/board/review/list'/>" class="btn btn-list">목록</a>
            </div>
        </main>
    </div>
<script>
	const isUserLiked = ${isLiked != null ? isLiked : false}; // Controller 값이 null일 경우 false 기본값
	console.log("isLiked from server:", isUserLiked); // 콘솔에 값 출력해보기
		document.addEventListener('DOMContentLoaded', () => {
			
			  const boardNo = document.getElementById('boardNo')?.value;
			  const boardType = document.getElementById('boardType')?.value;
			  const commentListArea = document.getElementById('commentListArea');
			  const contentTextArea = document.getElementById('commentContent');
			  const submitBtn = document.getElementById('commentSubmitBtn');
			  

			  function loadComments() {
				  console.log(`댓글 로딩 요청: /board/comment/list?boardType=${"$"}{boardType}&boardNo=${"$"}{boardNo}`);
				  
				  fetch("/board/comment/list?boardType=" + boardType + "&boardNo=" + boardNo)
					.then(response => response.json())
					.then(cmList => {
						const cmListUl = document.querySelector("#commentListArea");
						cmListUl.innerHTML = ""; // 기존 댓글 초기화
						
						if (!Array.isArray(cmList)) {
					        console.error("⚠️ 댓글 응답이 배열이 아님:", cmList);
					        return;
					      }
						
						cmList.forEach(comment => {
							// li태그 생성
							const li = document.createElement("li");
							li.classList.add("comment-item");
							li.dataset.commentNo = comment.commentNo;
							
							const infoDiv = document.createElement("div");
							infoDiv.classList.add("comment-info");
							
							const name = document.createElement("span");
							name.innerText = comment.writerNickname || comment.memberId || "익명";
							
							const commentDate = document.createElement("span");
							const date = new Date(comment.commentDate);
							commentDate.innerText = date.toLocaleString("ko-KR", {
								  year: "numeric",
								  month: "2-digit",
								  day: "2-digit",
								  hour: "2-digit",
								  minute: "2-digit"
								});
							
							infoDiv.append(name, commentDate);
							
							const commentContent = document.createElement("p");
							commentContent.innerText = comment.commentContent;
							commentContent.classList.add("comment-content");
							
							const btnDiv = document.createElement("div");
							btnDiv.classList.add("comment-actions");
							
							const replyBtn = document.createElement("button");
							replyBtn.innerText = "답글";
							
							const modifyBtn = document.createElement("button");
							modifyBtn.innerText = "수정";
							modifyBtn.classList.add("edit-btn");
							
							const deleteBtn = document.createElement("button");
							deleteBtn.innerText = "삭제";
							
							// 삭제 기능
							 deleteBtn.addEventListener("click", () => {
					          if (!confirm("정말 삭제하시겠습니까?")) return;
					
					          fetch("/board/comment/delete", {
					            method: "POST",
					            headers: { "Content-Type": "application/x-www-form-urlencoded" },
					            body: new URLSearchParams({ commentNo: comment.commentNo })
					          })
					            .then(res => {
					              if (!res.ok) throw new Error("서버 오류: " + res.status);
					              return res.json();
					            })
					            .then(result => {
					              if (result.status === "success") {
					                alert("댓글이 삭제되었습니다.");
					                loadComments();
					              } else {
					                alert(result.message || "댓글 삭제 실패");
					              }
					            })
					            .catch(err => alert("삭제 중 오류 발생: " + err));
					        });
						
							 btnDiv.append(replyBtn, modifyBtn, deleteBtn);
				        	li.append(infoDiv, commentContent, btnDiv);
					        cmListUl.append(li);
						});
					})
					.catch(error => alert("Error : " + error));
				}
			  loadComments();

			  // 등록
			  if (submitBtn) {
			    submitBtn.addEventListener('click', () => {
			      const content = contentTextArea.value.trim();
			      if (!content) return alert('댓글 내용을 입력하세요.');

			      const params = new URLSearchParams();
			      params.append('boardType', boardType);
			      params.append('boardNo', boardNo);
			      params.append('commentContent', content);

			      fetch('/board/comment/insert', {
			        method: 'POST',
			        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
			        body: params.toString()
			      })
			        .then(res => res.json())
			        .then(r => {
			          if (r.status === 'success') {
			            contentTextArea.value = '';
			            loadComments();
			          } else alert(r.message || '댓글 등록 실패');
			        });
			    });
			  }

			  // 수정 / 삭제
			  commentListArea.addEventListener('click', e => {
				  e.stopPropagation();
				  e.preventDefault();  
				  
			    const target = e.target;
			    const li = target.closest('.comment-item');
			    if (!li) return;
			    const commentNo = li.dataset.commentNo;

			    // 수정
			    if (target.classList.contains('edit-btn')) {
			    e.preventDefault(); // 링크 이동 방지
			      const contentP = li.querySelector('.comment-content');
			      const oldContent = contentP.textContent;
			      const textarea = document.createElement('textarea');
			      textarea.value = oldContent;
			      textarea.style.width = '100%';
			      contentP.replaceWith(textarea);
			      
			      target.textContent = '저장';
			      target.classList.remove('edit-btn');
			      target.classList.add('save-btn');
			      return;
			    }

			    // 저장
			    if (target.classList.contains('save-btn')) {
			      const textarea = li.querySelector('textarea');
			      const newContent = textarea.value.trim();
			      if (!newContent) return alert('내용을 입력하세요.');
			      const params = new URLSearchParams();
			      params.append('commentNo', commentNo);
			      params.append('commentContent', newContent);
			      fetch('/board/comment/update', {
			        method: 'POST',
			        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
			        body: params
			      })
			        .then(res => res.json())
			        .then(r => {
			          if (r.status === 'success') {
			        	  loadComments();
			          }
			          else alert(r.message || '수정 실패');
			        });
			    }
			  });
		
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
		 // ===== 북마크 기능 =====
		    const bookmarkBtn = document.getElementById('bookmarkBtn');
		    if (bookmarkBtn) {
		      const targetType = bookmarkBtn.dataset.targetType;
		      const targetNo = bookmarkBtn.dataset.targetNo;
		      const icon = bookmarkBtn.querySelector('i');

		      // 초기 상태 불러오기
		      fetch(`/board/bookmark/check?targetType=${targetType}&targetNo=${targetNo}`)
		        .then(res => res.json())
		        .then(isBookmarked => {
		          if (isBookmarked) {
		            bookmarkBtn.classList.add('bookmarked');
		            icon.classList.replace('fa-regular', 'fa-solid');
		            icon.style.color = '#007bff';
		          }
		        });

		      // 클릭 시 토글
		      bookmarkBtn.addEventListener('click', () => {
		        const isLoggedIn = "${sessionScope.loginMember != null}";
		        if (isLoggedIn !== "true") {
		          alert('로그인 후 이용 가능합니다.');
		          location.href = '<c:url value="/member/login"/>';
		          return;
		        }

		        fetch('/board/bookmark/toggle', {
		          method: 'POST',
		          headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
		          body: new URLSearchParams({
		            targetType: targetType,
		            targetNo: targetNo
		          })
		        })
		          .then(res => res.json())
		          .then(data => {
		            if (data.status === 'success') {
		              if (data.isBookmarked) {
		                bookmarkBtn.classList.add('bookmarked');
		                icon.classList.replace('fa-regular', 'fa-solid');
		                icon.style.color = '#007bff';
		              } else {
		                bookmarkBtn.classList.remove('bookmarked');
		                icon.classList.replace('fa-solid', 'fa-regular');
		                icon.style.color = '';
		              }
		            }
		          })
		          .catch(err => console.error('북마크 오류:', err));
		      });
		    }
			// ===== 신고 버튼 이동 =====
			  const reportBtn = document.getElementById('reportBtn');
			  if (reportBtn) {
			    reportBtn.addEventListener('click', () => {
			      const isLoggedIn = "${sessionScope.loginMember != null}";
			      if (isLoggedIn !== "true") {
			        alert("로그인 후 이용 가능합니다.");
			        location.href = "<c:url value='/member/login'/>";
			        return;
			      }
			      location.href = "<c:url value='/board/report/insert'/>";
			    });
			  }
		});
</script>
</body>
</html>