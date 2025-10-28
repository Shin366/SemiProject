<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 게시판</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">
    <style>
        /* 1번 JSP와 공통 스타일 생략 */
        body { font-family: sans-serif; background-color: #f8f9fa; margin: 0; }
        .container { display: flex; max-width: 1200px; margin: 20px auto; gap: 20px; }
        .sidebar { flex: 0 0 180px; }
        .sidebar a { display: block; padding: 12px 20px; text-decoration: none; color: #333; border-radius: 8px; font-weight: 500; }
        .sidebar a.active { background-color: #007bff; color: white; font-weight: bold; }
        .main-content { flex-grow: 1; background-color: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .page-title { font-size: 28px; font-weight: bold; margin-top: 0; margin-bottom: 30px; }

        .post-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #333; padding-bottom: 15px; }
        .post-title { font-size: 24px; margin: 0; }
        .post-author { color: #888; }
        .post-body { padding: 30px 0; min-height: 150px; font-size: 16px; line-height: 1.8; border-bottom: 1px solid #dee2e6;}
        
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
          <a href="/board/notice/list">공지 사항</a>
            <a href="/board/faq/list">자주 묻는 질문</a>
            <a href="/board/qna/list" class="active">1:1 문의</a>
            <a href="/board/report/list">신고 게시판</a>
        </aside>
        <main class="main-content">
            <h1 class="page-title">문의 게시판</h1>
            <div class="post-header">
                <h2 class="post-title">${boardQna.qnaTitle}</h2>
                <span class="post-author">${boardQna.writer}</span>
            </div>
            <div class="post-body">
                <p>${boardQna.qnaContent}</p>
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

			<!-- 댓글 영역 -->
            <section class="comment-section">
                <!-- 댓글 입력 -->
			<div class="comment-form">
			    <input type="hidden" id="commentBoardNo" value="${boardQna.qnaNo}">
			    <input type="hidden" id="commentBoardType" value="QNA">
			
			    <textarea id="commentContent" placeholder="따뜻한 댓글을 남겨주세요..."></textarea>
			    <div style="text-align: right; margin-top: 10px;">
			        <button id="commentSubmitBtn" type="button" class="btn btn-submit">등록</button>
			    </div>
			</div>
			
			<!-- 댓글 목록 -->
			<ul class="comment-list" id="commentListArea">
			    <c:forEach var="comment" items="${commentList}">
			        <li class="comment-item">
			            <p class="comment-author">${comment.writerNickName}</p>
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
                    <c:if test="${sessionScope.loginMember.memberNo == boardQna.memberNo}">
                        <a href="<c:url value='/board/qna/update?qnaNo=${boardQna.qnaNo}'/>" class="btn">수정</a>
                        <a href="<c:url value='/board/qna/delete?qnaNo=${boardQna.qnaNo}'/>" class="btn">삭제</a>
                    </c:if>
                </div>
                <a href="<c:url value='/board/qna/list'/>" class="btn btn-list">목록</a>
            </div>
        </main>
    </div>
</body>
</html>