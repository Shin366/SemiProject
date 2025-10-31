<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forTrip - 공지사항 관리</title>
<link href="../../../resources/img/common/eyes-icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="../../../resources/css/admin/noticeSet.css">
</head>
<body>
	<c:if test="${not empty success }">
		<script>
			alert("${success}"});
			window.loaction.href="/admin/main";
		</script>
	</c:if>
	<c:if test="${not empty error }">
		<script>
			alert("${error}");
		</script>
	</c:if>
    <div id="container">
        <jsp:include page="/WEB-INF/views/admin/include/header.jsp"/>
        <div id="main">
            <div id="notice-wrapper">
                <h1>공지사항</h1>
                <form action="/notice/insert" method="post" enctype="multipart/form-data">
                   <div class="form-group">
                        <label for="notice-title">제목</label>
                        <input type="text" name="noticeTitle" id="notice-title" placeholder="공지 제목을 입력하세요" required>
                    </div>
	
                    <div class="form-group">
                        <label for="notice-content">내용</label>
                        <textarea id="notice-content" name="noticeContent" rows="10" placeholder="공지 내용을 입력하세요" required></textarea>
                    </div>
                  
                    <div class="btn-row">
                        <button type="submit" id="notice-save-btn">등록하기</button>
                        <button type="button" id="notice-cancel-btn" onclick="cancelBtn();">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="../../resources/css/admin/js/cancelBtn.js"></script>
</body>
</html>