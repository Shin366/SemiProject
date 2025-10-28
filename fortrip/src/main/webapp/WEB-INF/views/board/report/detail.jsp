<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고 내역 상세 - 고객지원</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
    <link rel="stylesheet" href="<c:url value='/resources/css/common/header.css'/>">
    <style>
        /* --- 기본 & 레이아웃 --- */
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; background-color: #f8f9fa; margin: 0; padding: 20px; color: #343a40; }
        .report-container { max-width: 800px; margin: 40px auto; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); overflow: hidden; }
        .report-card { padding: 40px 50px; }
        .card-header h2 { margin: 0 0 30px 0; font-size: 26px; font-weight: 700; color: #212529; border-bottom: 1px solid #e0e0e0; padding-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .card-header h2 i { color: #dc3545; }

        /* --- 상세 내용 --- */
        .detail-section { margin-bottom: 35px; }
        .detail-section h3 { font-size: 18px; margin-bottom: 15px; font-weight: 600; color: #343a40; }
        .detail-value { font-size: 16px; color: #212529; padding: 15px; background-color: #f8f9fa; border-radius: 6px; border: 1px solid #e9ecef; white-space: pre-wrap; word-wrap: break-word; line-height: 1.7; }
        
        .reason-group { display: flex; flex-wrap: wrap; gap: 10px; }
        .reason-option { display: flex; align-items: center; background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 6px; padding: 8px 14px; cursor: default; font-size: 15px; }
        .reason-option input { margin-right: 8px; }
        .reason-option input:checked + span { font-weight: 600; color: #0d6efd; }
        .reason-option input[disabled] + span { opacity: 1; }

        .attachment-list ul { list-style: none; padding: 0; margin: 0; }
        .attachment-list li { margin-bottom: 8px; }
        .attachment-list a { text-decoration: none; color: #007bff; font-size: 15px; }
        .attachment-list a:hover { text-decoration: underline; }

        /* --- 댓글 --- */
        .comments-section { border-top: 1px solid #e0e0e0; padding-top: 30px; }
        .no-comments { color: #888; text-align: center; padding: 20px; }
        .comment-form textarea { width: 100%; min-height: 80px; padding: 10px; font-size: 14px; border: 1px solid #dee2e6; border-radius: 6px; box-sizing: border-box; resize: vertical; margin-bottom: 10px;}
        .comment-form-actions { text-align: right; }
        .comment-list { margin-top: 30px; list-style: none; padding: 0; }
        .comment-item { padding: 15px 0; border-top: 1px solid #f1f3f5; }
        .comment-item:first-child { border-top: 2px solid #343a40; }
        .comment-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 5px;}
        .comment-author { font-weight: bold; font-size: 15px; }
        .comment-date { font-size: 12px; color: #888; }
        .comment-content { color: #495057; line-height: 1.6; margin-bottom: 10px; font-size: 14px; white-space: pre-wrap;}
        .edit-comment-textarea { width: 100%; min-height: 60px; margin-top: 5px; display: none; box-sizing: border-box; }
        .comment-actions { text-align: right; font-size: 12px; }
        .comment-actions button { background: none; border: none; color: #007bff; cursor: pointer; padding: 0 5px; font-size: 12px; }
        .comment-actions button:hover { text-decoration: underline; }

        /* --- 하단 버튼 --- */
        .button-group { text-align: right; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e9ecef; }
        .btn { padding: 10px 20px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; text-decoration: none; font-weight: 500; }
        .btn-secondary { background-color: #6c757d; color: white; margin-right: 10px; }
        .btn-danger { background-color: #dc3545; color: white; }
        .btn-submit { background-color: #007bff; color: white; border: none; }
    </style>
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

<div class="report-container">
    <div class="report-card">
        <div class="card-header">
            <h2><i class="fa-solid fa-file-contract"></i> 신고 내역 상세</h2>
        </div>

        <%-- hidden input (ID 중복 제거) --%>
        <input type="hidden" id="boardType" value="REPORT">
        <input type="hidden" id="boardNo" value="${report.reportNo}">

        <div class="detail-section">
            <h3>신고 사유</h3>
            <div class="reason-group">
                <%-- JSTL을 이용해 선택된 사유만 간단히 표시 --%>
                <span class="reason-option">
                    <span>
                        <c:choose>
                            <c:when test="${report.reportReason == 'SPAM'}">스팸 홍보 / 도배</c:when>
                            <c:when test="${report.reportReason == 'OBSCENE'}">음란물</c:when>
                            <c:when test="${report.reportReason == 'ILLEGAL'}">불법 정보</c:when>
                            <c:when test="${report.reportReason == 'ABUSE'}">욕설 / 비방 / 혐오</c:when>
                            <c:when test="${report.reportReason == 'PRIVACY'}">개인정보 노출</c:when>
                            <c:when test="${report.reportReason == 'INAPPROPRIATE'}">불쾌한 표현</c:when>
                            <c:otherwise>기타 (${report.reportReason})</c:otherwise>
                        </c:choose>
                    </span>
                </span>
            </div>
        </div>

        <div class="detail-section">
            <h3>상세 내용</h3>
            <div class="detail-value">${report.reportContent}</div>
        </div>

        <div class="detail-section attachment-list">
            <h3>첨부 파일</h3>
            <ul>
                <c:forEach var="file" items="${attachmentList}">
                    <li><a href="<c:url value='/download?fileId=${file.attachNo}'/>">${file.originalName}</a></li>
                </c:forEach>
                <c:if test="${empty attachmentList}">
                    <li>첨부된 파일이 없습니다.</li>
                </c:if>
            </ul>
        </div>

        <div class="detail-section comments-section"> <%-- admin-response -> comments-section --%>
            <h3>관리자 답변</h3>
            <ul id="commentListArea" class="comment-list"></ul> <%-- class 추가 --%>

            <%-- 댓글 입력 폼 (로그인 시에만 표시) --%>
            <c:if test="${not empty sessionScope.loginMember}">
                <div class="comment-form">
                    <textarea id="commentContent" placeholder="댓글을 입력하세요."></textarea>
                    <div class="comment-form-actions">
                        <button id="commentSubmitBtn" type="button" class="btn btn-submit">등록</button>
                    </div>
                </div>
            </c:if>
             <c:if test="${empty sessionScope.loginMember}">
                <p style="text-align:center; color:#888; font-size: 14px; margin-top: 20px;">댓글을 작성하려면 <a href="<c:url value='/member/login'/>">로그인</a>해주세요.</p>
            </c:if>
        </div>

        <div class="button-group">
            <c:if test="${not empty sessionScope.loginMember && sessionScope.loginMember.memberNo == report.memberNo}">
                <button type="button" class="btn btn-danger" onclick="deleteReport(${report.reportNo})">삭제</button>
            </c:if>
            <a href="<c:url value='/board/report/list'/>" class="btn btn-secondary">목록</a>
        </div>
    </div>
</div>

<form id="deleteForm" method="post" action="<c:url value='/board/report/delete'/>">
    <input type="hidden" name="reportNo" id="deleteReportNo">
</form>

<script>
function deleteReport(reportNo) {
    if (confirm("정말로 이 신고 내역을 삭제하시겠습니까?")) {
        document.getElementById('deleteReportNo').value = reportNo;
        document.getElementById('deleteForm').submit();
    }
}

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
		  });
</script>
</body>
</html>