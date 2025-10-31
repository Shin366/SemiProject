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
            
			<!-- 댓글 영역 -->
            <section class="comment-section">
                <!-- 댓글 입력 -->
			<div class="comment-form">
			    <input type="hidden" id="BoardNo" value="${boardQna.qnaNo}">
			    <input type="hidden" id="BoardType" value="QNA">
			
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
<script>

//로그인 회원 번호 (세션 없을 경우 0)
const loginMemberNo = ${not empty sessionScope.loginMember ? sessionScope.loginMember.memberNo : 0};

// JSP 숨김 input에서 값 읽기
const boardNo = document.getElementById("BoardNo")?.value;
const boardType = document.getElementById("BoardType")?.value;

// 댓글 입력창, 등록 버튼, 댓글 목록 영역
const contentTextArea = document.getElementById("commentContent");
const submitBtn = document.getElementById("commentSubmitBtn");
const commentListArea = document.getElementById("commentListArea");

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

</script>

</body>
</html>