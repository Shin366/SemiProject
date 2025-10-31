<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ForTrip - 자유게시판 상세페이지</title>
    <%-- Font Awesome CDN (아이콘 사용을 위해 추가) --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
    <link rel="stylesheet" href="/resources/css/common/base-layout.css">
    <link rel="stylesheet" href="/resources/css/board/free/detail.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="container">
        <aside class="sidebar">
            <ul>
                <li><a href="<c:url value='/board/free/list'/>" class="active">자유 소통</a></li>
                <li><a href="#">코스 리뷰</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <!-- <h1 class="page-title">자유 게시판</h1> -->

            <div class="post-container">
                <h2 class="post-title">${free.postTitle}</h2>
                <div class="post-meta">
                    <span>작성자: ${free.postWriter}</span>
                    <span><fmt:formatDate value="${free.writeDate}" pattern="yyyy.MM.dd HH:mm"/></span>
                    <span>조회 ${free.viewCount}</span>
                </div>
                <div class="post-content">
                    <p>${free.postContent}</p>
                </div>
                <div class="attachment-section">
				    <strong>첨부 파일 :</strong>
				    <c:forEach var="file" items="${attachmentList}">
				         <!-- 다운로드 링크 구현 필요 -->
				        <a href="<c:url value='/download?fileId=${file.attachNo}'/>">${file.originalName}</a>
				    </c:forEach>
				    <c:if test="${empty attachmentList}">
				        <span>첨부파일이 없습니다.</span>
				    </c:if>
				</div>

                <div class="post-footer">
                    <div class="reaction-buttons">
                        <button class="btn" id="likeBtn" data-board-type="FREE" data-board-no="${free.postNo}">
                            <i class="fa-regular fa-heart"></i> <span id="likeCount">${likeCount}</span>
                        </button>
                        <button class="btn" id="bookmarkBtn"
					        data-target-type="FREE"
					        data-target-no="${free.postNo != null ? free.postNo : 0}">
						    <i class="fa-regular fa-bookmark"></i>
						    <span id="bookmarkCount">${free.bookmarkCount}</span>
						</button>
                    </div>
                    <div class="social-share">
					  <a href="javascript:shareTwitter();" title="트위터 공유">
					    <i class="fab fa-twitter"></i>
					  </a>
					  <a href="javascript:shareFacebook();" title="페이스북 공유">
					    <i class="fab fa-facebook"></i>
					  </a>
					  <a href="javascript:shareKakao();" title="카카오톡 공유">
					    <i class="fa-solid fa-comment"></i>
					  </a>
					</div>
                </div>
            </div>

            <section class="comments-section">
            <!-- 댓글 입력 -->
			<div class="comment-form">
			    <input type="hidden" id="boardNo" value="${free.postNo}">
			    <input type="hidden" id="boardType" value="FREE">
			
			    <textarea id="commentContent" placeholder="따뜻한 댓글을 남겨주세요..."></textarea>
			    <div style="text-align: right; margin-top: 10px;">
			        <button id="commentSubmitBtn" type="button" class="btn btn-submit">등록</button>
			    </div>
			</div>
			<!-- 댓글 목록 -->
			<ul class="comment-list" id="commentListArea">
			    <c:forEach var="comment" items="${commentList}">
			        <li class="comment-item">
			            <p class="comment-author">${comment.writerNickname}</p>
			            <p class="comment-content">${comment.commentContent}</p>
			            
			            <%-- <c:if test="${sessionScope.loginMember.memberNo == comment.memberNo}"> --%>
			            <c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberNo eq comment.memberNo}">
			                <div class="comment-actions" style="text-align:right; font-size:12px; margin-top: 10px;">
			                    <button type="button" class="edit-btn">수정</button>	
								<button type="button" class="delete-btn">삭제</button>
			                </div>
			            </c:if>
			        </li>
			    </c:forEach>
			    <c:if test="${empty commentList}">
			        <p style="text-align:center; color:#888; padding: 30px 0;">작성된 댓글이 없습니다.</p>
			    </c:if>
			</ul>
            </section>

            <div class="bottom-actions">
                <div>
                    <c:if test="${not empty sessionScope.loginMember and sessionScope.loginMember.memberNo eq free.memberNo}">
                        <a href="<c:url value='/board/free/update?postNo=${free.postNo}'/>" class="btn">수정</a>
                        <a href="<c:url value='/board/free/delete?postNo=${free.postNo}'/>" class="btn">삭제</a>
                    </c:if>
                </div>
                <a href="<c:url value='/board/free/list'/>" class="btn btn-list">목록</a>
            </div>
            
        </main>
    </div>
<script>

/* sns */
function shareTwitter() {
	  const sendText = document.querySelector(".post-title")?.innerText || "ForTrip 게시글";
	  const sendUrl = window.location.href; // 현재 페이지 URL
	  const twitterUrl = "https://twitter.com/intent/tweet?text=" + encodeURIComponent(sendText) + "&url=" + encodeURIComponent(sendUrl);
	  window.open(twitterUrl, "_blank", "width=600,height=400");
	}
	
	function shareFacebook() {
	  const sendUrl = window.location.href;
	  const facebookUrl = "https://www.facebook.com/sharer/sharer.php?u=" + encodeURIComponent(sendUrl);
	  window.open(facebookUrl, "_blank", "width=600,height=400");
	}
	
	function shareKakao() {
		  if (!window.Kakao) {
		    alert("카카오 SDK 로드 실패");
		    return;
		  }
		  if (!Kakao.isInitialized()) {
		    Kakao.init("034bf29dca5f7d44b97a184fa1e175fc");
		  }
		  Kakao.Link.sendDefault({
		    objectType: "feed",
		    content: {
		      title: document.querySelector(".post-title")?.innerText || "ForTrip 게시글",
		      description: "ForTrip 자유게시판 글을 확인해보세요.",
		      imageUrl: "https://yourdomain.com/resources/img/fortrip-logo.png",
		      link: { mobileWebUrl: window.location.href, webUrl: window.location.href }
		    },
		    buttons: [
		      { title: "게시글 보기", link: { mobileWebUrl: window.location.href, webUrl: window.location.href } }
		    ]
		  });
		}


	const isUserLiked = ${isLiked != null ? isLiked : false}; // Controller 값이 null일 경우 false 기본값
	console.log("isLiked from server:", isUserLiked); // 콘솔에 값 출력해보기
	
		document.addEventListener('DOMContentLoaded', () => {
			
			const loginMemberNo = ${not empty sessionScope.loginMember ? sessionScope.loginMember.memberNo : 0};
		    console.log("Login Member No:", loginMemberNo);
			
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
							li.dataset.memberNo = comment.memberNo; // 댓글 작성자 번호 지정
							
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
							
							const modifyBtn = document.createElement("button");
							modifyBtn.innerText = "수정";
							modifyBtn.classList.add("edit-btn");
							
							const deleteBtn = document.createElement("button");
							deleteBtn.innerText = "삭제";
							
							if (parseInt(comment.memberNo) === loginMemberNo) {
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
							 btnDiv.append(modifyBtn, deleteBtn); // 본인만 버튼 추가
							}
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

			  // 수정
			  commentListArea.addEventListener('click', e => {
				  e.stopPropagation();
				  e.preventDefault();  
				  
				  const target = e.target;
				  const li = target.closest('.comment-item');
				  if (!li) return;
				  
				  const commentWriterNo = parseInt(li.dataset.memberNo); // 댓글 작성자 번호
				  const commentNo = li.dataset.commentNo;

			    // 수정 버튼 클릭 시
			    if (target.classList.contains('edit-btn')) {
			    	e.preventDefault(); // 링크 이동 방지
			    	
				    if (loginMemberNo !== commentWriterNo) {
				      alert("본인 댓글만 수정할 수 있습니다.");
				      return;
				    }

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
		      
		      if (!targetType || !targetNo || targetNo === "0") {
		    	  console.warn("북마크 대상 데이터 누락:", targetType, targetNo);
		    	  return; // fetch 호출하지 않음
		    	}

		      console.log("초기 targetType:", targetType, "targetNo:", targetNo);

		      fetch(`/board/bookmark/check?targetType=${targetType}&targetNo=${targetNo}`)
		        .then(res => res.json())
		        .then(isBookmarked => {
		          if (isBookmarked) {
		            bookmarkBtn.classList.add('bookmarked');
		            icon.classList.replace('fa-regular', 'fa-solid');
		            icon.style.color = '#007bff'; // 파란색
		          }else {
		              bookmarkBtn.classList.remove('bookmarked');
		              icon.classList.replace('fa-solid', 'fa-regular');
		              icon.style.color = ''; // 기본 회색으로 초기화
		            }
		        })
		        .catch(err => console.error("북마크 초기 확인 실패:", err));

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
		              const icon = bookmarkBtn.querySelector('i');
		              document.getElementById('bookmarkCount').textContent = data.bookmarkCount;
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
		          });
		      });
		    }
		});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>	
</body>
</html>