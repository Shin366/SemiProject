<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 아이디찾기</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="/resources/css/member/idSearch.css">
</head>
<body>
	<div id="container">
        <main id="main">
            <div class="idSearch-container">
                <div class="idSearch-title">
                    <h2>아이디 찾기</h2>
                </div>
                <form class="idSearch-form" action="/member/idSearch" method="post">
                    <div class="form-group">
                        <label class="required" for="memberName">이름</label>
                        <input type="text" name="memberName" placeholder="이름을 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label class="required" for="email">이메일</label>
                        <input type="text" name="email" placeholder="이메일을 입력해주세요." required>
                    </div>
                    <button type="submit">확인</button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>