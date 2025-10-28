<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ForTrip - 자유게시판 상세페이지</title>
    <%-- Font Awesome CDN (아이콘 사용을 위해 추가) --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
    <style>
        /* --- 기본 & 레이아웃 --- */
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; background-color: #f8f9fa; margin: 0; color: #343a40; }
        .container { display: flex; max-width: 1200px; margin: 30px auto; gap: 30px; }
        .sidebar { flex: 0 0 200px; }
        .main-content { flex-grow: 1; background-color: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.06); }

        /* --- 사이드바 --- */
        .sidebar ul { list-style: none; padding: 0; background-color: #fff; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.05); padding: 10px; }
        .sidebar a { display: block; padding: 15px 20px; text-decoration: none; color: #555; border-radius: 6px; font-weight: 600; font-size: 16px; }
        .sidebar a.active, .sidebar a:hover { background-color: #007bff; color: white; }

        /* --- 게시글 영역 --- */
        .page-title { font-size: 28px; font-weight: bold; margin-top: 0; margin-bottom: 30px; border-bottom: 1px solid #eee; padding-bottom: 20px;}
        .post-title { font-size: 28px; font-weight: 700; margin: 0; }
        .post-meta { display: flex; align-items: center; gap: 15px; color: #868e96; font-size: 14px; margin-top: 15px; padding-bottom: 25px; border-bottom: 1px solid #dee2e6; }
        .post-content { padding: 30px 0; min-height: 250px; font-size: 16px; line-height: 1.8; border-bottom: 1px solid #dee2e6; }
        
        /* 첨부파일 영역 */
        .attachment-section {margin : 10px;}
        /* --- 버튼 영역 (좋아요, 공유 등) --- */
        .post-footer { display: flex; justify-content: space-between; align-items: center; margin-top: 20px; }
        .reaction-buttons { display: flex; gap: 8px; }
        .reaction-buttons .btn { display: flex; align-items: center; gap: 6px; background-color: #f1f3f5; border: 1px solid #dee2e6; padding: 8px 15px; border-radius: 20px; cursor: pointer; font-size: 14px; transition: all 0.2s ease; }
        .reaction-buttons .btn:hover { transform: translateY(-2px); box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .reaction-buttons .btn.liked { background-color: #ffe0e0; border-color: #ffc2c2; color: #dc3545; font-weight: bold; }
        .social-share a { color: #adb5bd; font-size: 24px; margin-left: 15px; text-decoration: none; transition: color 0.2s ease; }
        .social-share a:hover { color: #343a40; }

        /* --- 댓글 영역 --- */
        .comments-section { margin-top: 50px; }
        .comment-form textarea { width: 100%; min-height: 80px; padding: 12px; border: 1px solid #ced4da; border-radius: 6px; resize: vertical; box-sizing: border-box; font-size: 15px; }
        .comment-form-actions { text-align: right; margin-top: 10px; }
        .btn { padding: 8px 18px; border-radius: 6px; text-decoration: none; font-size: 14px; font-weight: 500; border: 1px solid #ced4da; background-color: #fff; cursor: pointer; }
        .btn-submit { background-color: #007bff; color: white; border: none; }
        
        .comment-list { margin-top: 30px; list-style: none; padding: 0; }
        .comment-item { padding: 20px 0; border-top: 1px solid #f1f3f5; }
        .comment-item:first-child { border-top: 2px solid #343a40; }
        .comment-author { font-weight: bold; margin-bottom: 5px; }
        .comment-content { color: #495057; line-height: 1.6; }

        /* --- 하단 버튼 (목록, 수정, 삭제) --- */
        .bottom-actions { display: flex; justify-content: space-between; align-items: center; margin-top: 40px; }
        .btn-list { background-color: #343a40; color: white; border-color: #343a40; padding: 12px 25px; font-weight: bold; }
    </style>
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
            <h1 class="page-title">자유 게시판</h1>

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
                        <button class="btn" id="bookmarkBtn" data-target-type="FREE" data-target-no="${free.postNo}">
                            <i class="fa-regular fa-bookmark"></i> 북마크
                        </button>
                    </div>
                    <div class="social-share">
                        <a href="#" title="페이스북 공유"><i class="fab fa-facebook-square"></i></a>
                        <a href="#" title="트위터 공유"><i class="fab fa-twitter"></i></a>
                        <a href="#" title="링크 복사"><i class="fa-solid fa-link"></i></a>
                    </div>
                </div>
            </div>

            <section class="comments-section">
            <!-- 댓글 입력 -->
			<div class="comment-form">
			    <input type="hidden" id="commentBoardNo" value="${free.postNo}">
			    <input type="hidden" id="commentBoardType" value="FREE">
			
			    <textarea id="commentContent" placeholder="따뜻한 댓글을 남겨주세요..."></textarea>
			    <div style="text-align: right; margin-top: 10px;">
			        <button id="commentSubmitBtn" type="button" class="btn btn-submit">등록</button>
			    </div>
			</div>
			
			<!-- 댓글 목록 -->
			<input type="hidden" id="commentBoardNo" value="${free.postNo}">
			<input type="hidden" id="commentBoardType" value="FREE">
			<ul class="comment-list" id="commentListArea">
			    <c:forEach var="comment" items="${commentList}">
			        <li class="comment-item">
			            <p class="comment-author">${comment.writerNickname}</p>
			            <p class="comment-content">${comment.commentContent}</p>
			            
			            <c:if test="${sessionScope.loginMember.memberNo == comment.memberNo}">
			                <div class="comment-actions" style="text-align:right; font-size:12px; margin-top: 10px;">
			                    <a href="#">수정</a> | <a href="#">삭제</a>
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
                    <c:if test="${sessionScope.loginMember.memberNo == free.memberNo}">
                        <a href="<c:url value='/board/free/update?postNo=${free.postNo}'/>" class="btn">수정</a>
                        <a href="<c:url value='/board/free/delete?postNo=${free.postNo}'/>" class="btn">삭제</a>
                    </c:if>
                </div>
                <a href="<c:url value='/board/free/list'/>" class="btn btn-list">목록</a>
            </div>
            
        </main>
    </div>
<script>
	const isUserLiked = ${isLiked != null ? isLiked : false}; // Controller 값이 null일 경우 false 기본값
	console.log("isLiked from server:", isUserLiked); // 콘솔에 값 출력해보기
		document.addEventListener('DOMContentLoaded', () => {
		
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