<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>forTrip - 공지사항 관리</title>
<link href="../resources/admin/img/eyes-icon.png" rel="shortcut icon" type="image/x-icon">
<link rel="stylesheet" href="../resources/admin/css/noticeSet.css">
</head>
<body>
    <div id="container">
        <jsp:include page="/WEB-INF/views/admin/include/header.jsp"/>
        <div id="main">
            <div id="notice-wrapper">
                <h1>공지사항</h1>
                <form action="/notice/insert" method="post" enctype="multipart/form-data">
                   <div class="form-group">
                        <label for="notice-title">제목</label>
                        <input type="text" name="noticeTitle" id="notice-title" placeholder="공지 제목을 입력하세요">
                    </div>

                    <div class="form-group">
                        <label for="notice-content">내용</label>
                        <textarea id="notice-content" name="noticeContent" rows="10" placeholder="공지 내용을 입력하세요"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="notice-file">첨부 파일</label>
                        <input type="file" name="uploadfile" id="notice-file" onchange="loadImage(this);"/>
                        <div id="img-viewer">
                        	<img src="" alt="" id="img-view" width="300">
                        	<button type="button" id="delete-btn">삭제</button>
                        </div>
                    </div>

                    <div class="btn-row">
                        <button type="submit" id="notice-save-btn">등록하기</button>
                        <button type="button" id="notice-cancel-btn">취소</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
	    const deleteImg = document.querySelector("#delete-btn");
	    const noticefile = document.querySelector("#notice-file");
	    const imageView = document.querySelector("#img-view");
	    
        function loadImage(img) {
            // img.files -> 업로드한 파일의 정보가 나온다.
            if(img.files.length != 0 && img.files[0] != 0) {
                let reader = new FileReader();
                reader.readAsDataURL(img.files[0]);
                reader.onload = function(e) {
                    document.querySelector("#img-view").setAttribute("src", e.target.result);
                    deleteImg.style.visibility = "visible";
                    deleteImg.style.display = "flex";
                }
            } else {
                document.querySelector("#img-view").setAttribute("src","");
            }
        };
        
        document.querySelector("#delete-btn").addEventListener("click", function() {
            imageView.setAttribute("src", "");
            noticefile.value = "";
            deleteImg.style.visibility = "hidden";
        });
    </script>
</body>
</html>