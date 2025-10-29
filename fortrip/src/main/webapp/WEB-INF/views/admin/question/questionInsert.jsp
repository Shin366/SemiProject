<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forTrip - 질문관리</title>
<link href="../../../resources/img/common/eyes-icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="../../../resources/css/admin/questionSet.css">
</head>
<body>
	<div id="container">
	    <jsp:include page="/WEB-INF/views/admin/include/header.jsp"/>
	    <c:if test="${not empty QuestionSuccess}">
		<script>
        	alert("${QuestionSuccess}");
        	window.location.href = '/admin/main';
		</script>
		</c:if>
		<c:if test ="${not empty QuestionError }">
			<script>
	        	alert('<c:out value="${QuestionError}" />');
			</script>
		</c:if>
        <div id="main">
            <div id="question-wrapper">
                <h1>자주하는 질문 관리</h1>
                <form action="/question/insert" method="post">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="question-title">질문 제목</label>
                            <input type="text" name="questionTitle" id="question-title" placeholder="질문 제목을 입력하세요" required>
                        </div>
                        <div class="form-group">
                            <label for="questionCategory">질문 카테고리</label>
                            <select name="questionCategory" id="questionCategory">
                                <option value=" " selected disabled hidden>카테고리</option>
                                <option value="travel">여행 관련</option>
                                <option value="user">회원 관련</option>
                                <option value="community">커뮤니티 & 고객센터</option>
                                <option value="review">찜하기 및 리뷰</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="question-content">질문 답변</label>
                        <textarea id="question-content" name="questionContent" rows="10" placeholder="질문 답변을 작성해주세요" required></textarea>
                    </div>

                    <div class="btn-row">
                        <button type="submit" id="question-save-btn">등록하기</button>
                        <button type="button" id="question-cancel-btn" onclick="cancelBtn();">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="../../resources/css/admin/js/cancelBtn.js"></script>
    <script>
    	document.querySelector("#question-save-btn").addEventListener("click", (e) => {
    		const category = document.querySelector("#questionCategory").value;
    		if(category == " ") {
    			e.preventDefault();
    			alert("카테고리를 선택해주세요.");
    		} 
    	});
    </script>
</body>
</html>