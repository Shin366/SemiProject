<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 게시판</title>
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
        
        .answer-section { margin-top: 20px; }
        .answer-header { font-size: 16px; font-weight: bold; margin-bottom: 15px; }
        .answer-box { background-color: #f8f9fa; border: 1px solid #e9ecef; border-radius: 8px; padding: 20px; }
        .answer-author { font-weight: bold; margin-bottom: 10px; }
        
        .bottom-actions { text-align: right; margin-top: 20px; }
        .btn-list { background-color: #007bff; color: white; border: none; padding: 10px 24px; text-decoration: none; border-radius: 6px; }
    </style>
</head>
<body>
    <div class="container">
        <aside class="sidebar">
            <a href="#">공지 사항</a>
            <a href="#">자주 묻는 질문</a>
            <a href="#" class="active">1:1 문의</a>
            <a href="#">신고 게시판</a>
        </aside>
        <main class="main-content">
            <h1 class="page-title">문의 게시판</h1>
            <div class="post-header">
                <h2 class="post-title">${qna.title}</h2>
                <span class="post-author">${qna.writer}</span>
            </div>
            <div class="post-body">
                <p>${qna.content}</p>
            </div>

            <div class="answer-section">
                <h3 class="answer-header">댓글 1</h3>
                <c:choose>
                    <c:when test="${not empty qna.answer}">
                        <div class="answer-box">
                            <p class="answer-author">관리자</p>
                            <p>${qna.answer.content}</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p>아직 답변이 등록되지 않았습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="bottom-actions">
                <a href="/qna/list" class="btn-list">게시글 목록</a>
            </div>
        </main>
    </div>
</body>
</html>