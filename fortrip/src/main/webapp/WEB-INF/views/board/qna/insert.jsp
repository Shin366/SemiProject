<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>1:1 문의 작성 - 고객지원</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">
	<link rel="stylesheet" href="/resources/css/board/qna/insert.css">
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
            
            <form id="qnaForm" enctype="multipart/form-data">
                <div class="form-group title-group">
                    <input type="text" name="qnaTitle" placeholder="제목을 입력해주세요...." required>
                    <span class="author">${sessionScope.loginUser.nickname}</span>
                </div>
                <div class="form-group content-group">
                    <textarea name="qnaContent" placeholder="내용을 입력해주세요..." required></textarea>
                </div>
                <div class="form-group options-group" style="display: flex; gap: 20px; align-items: center;">
			        <div>
			            <label>비밀번호 (4자리):</label>
			            <input type="password" name="qnaPassword" maxlength="4" placeholder="숫자 4자리" required>
			        </div>
			        <div>
			            <label><input type="checkbox" name="isPrivate" value="Y" checked> 비밀글로 설정</label>
			        </div>
			    </div>
                <div class="form-group attachment-group">
                    <label>첨부 파일: </label>
                    <input type="file" name="files">
                </div>
                <div class="actions">
                    <button type="button" class="btn" onclick="history.back()">취소</button>
                    <button type="button" class="btn btn-submit" id="submitBtn">작성</button>
                </div>
            </form>
        </main>
    </div>

    <script>
        document.getElementById("submitBtn").addEventListener("click", function() {
            const form = document.getElementById("qnaForm");
            const formData = new FormData(form);

            fetch("/board/qna/insert", {
                method: "POST",
                body: formData
            })
            .then(response => {
                if (!response.ok) throw new Error("서버 응답 오류");
                return response.text();
            })
            .then(result => {
                if (parseInt(result) > 0) {
                    alert("문의글이 등록되었습니다.");
                    location.href = "/board/qna/list";
                } else {
                    alert("문의글 등록에 실패했습니다.");
                }
            })
            .catch(err => {
                console.error(err);
                alert("서버 통신 중 오류가 발생했습니다.");
            });
        });
    </script>
</body>
</html>
