<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ForTrip - 자유게시판 글쓰기</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">
	<link rel="stylesheet" href="/resources/css/common/rset.css">
	
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
        }
        .container {
            width: 1000px;
            margin: 50px auto;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            padding: 40px;
        }
        h2 {
            font-size: 1.8rem;
            color: #333;
            border-bottom: 2px solid #3b82f6;
            padding-bottom: 10px;
            margin-bottom: 30px;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 1rem;
        }
        textarea {
            resize: none;
            height: 300px;
        }
        .top-fields {
            display: flex;
            gap: 10px;
        }
        .top-fields input[name="writer"] {
            width: 200px;
        }
        .file-upload {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .buttons {
            text-align: right;
            margin-top: 20px;
        }
        .btn {
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 500;
        }
        .btn-submit {
            background-color: #3b82f6;
            color: white;
        }
        .btn-cancel {
            background-color: #e5e7eb;
            color: #333;
        }
    </style>
</head>
<body>
	<!-- header -->
   <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <h2>자유 게시판</h2>

        <form action="/board/free/insert" method="post" enctype="multipart/form-data">
            <div class="top-fields">
                <input type="text" name="postTitle" placeholder="제목을 입력해주세요..." required>
                <input type="text" name="writer" value="${loginMember.nickname}" readonly placeholder="작성자 닉네임">
            </div>

            <textarea name="postContent" placeholder="본문을 입력해주세요..." required></textarea>

            <div class="file-upload">
                <label>첨부 파일:</label>
                <input type="file" name="files">
            </div>

            <div class="buttons">
                <button type="button" class="btn btn-cancel" onclick="location.href='/board/free/list'">취소</button>
                <button type="submit" class="btn btn-submit">작성</button>
            </div>
        </form>
    </div>

	<!-- footer -->
   <%--  <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
</body>
</html>
