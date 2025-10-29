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
	<link rel="stylesheet" href="/resources/css/board/qna/detail.css">
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