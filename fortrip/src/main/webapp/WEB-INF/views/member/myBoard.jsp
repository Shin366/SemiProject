<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 내 게시글</title>
<link rel="icon" type="image/png" href="/resources/img/common/eyes-icon.png">
<link rel="stylesheet" href="/resources/css/member/myBoard.css">
</head>
<body>
<div id="container">
    <main id="main">
        <div class="sidebar">
            <ul class="menu-list">
                <li><a href="/member/profile">내 프로필</a></li>
                <li><a href="/member/myBoard">내 게시글</a></li>
                <li><a href="/member/list">찜 목록</a></li>
                <li><a href="/member/recent">최근 본 코스</a></li>
                <li><a href="/member/update">개인 정보 수정</a></li>
                <li><a href="/member/delete">회원탈퇴</a></li>
            </ul>
        </div>

        <div class="myboard-container">
            <div class="myboard-header">
                <h2>내 게시글</h2>
                <form method="get" action="/member/myBoard">
                    <select name="type" onchange="this.form.submit()">
                        <option value="all" ${type == 'all' ? 'selected' : ''}>전체</option>
                        <option value="community" ${type == 'community' ? 'selected' : ''}>커뮤니티</option>
                        <option value="review" ${type == 'review' ? 'selected' : ''}>리뷰</option>
                    </select>
                </form>
            </div>

            <table border="1" width="100%">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>게시판</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>좋아요</th>
                        <th>댓글</th>
                        <th>카테고리</th>
                        <th>코스번호</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="board" items="${boardList}" varStatus="status">
                        <tr>
                            <td>${status.count}</td>
                            <td>${board.boardType == 'community' ? '커뮤니티' : '리뷰'}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${board.boardType == 'community'}">
                                        <a href="/community/detail?no=${board.boardNo}">${board.title}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/review/detail?no=${board.boardNo}">${board.title}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${board.nickName}</td>
                            <td><fmt:formatDate value="${board.writeDate}" pattern="yyyy-MM-dd" /></td>
                            <td>${board.viewCount}</td>
                            <td>${board.bookmarkCount}</td>
                            <td>${board.commentCount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${board.boardType == 'review' && not empty board.category}">
                                        ${board.category}
                                    </c:when>
                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${board.boardType == 'review' && not empty board.courseName}">
                                        ${board.courseName}
                                    </c:when>
                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty boardList}">
                        <tr>
                            <td colspan="10" style="text-align:center;">작성한 게시글이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>
</body>
</html>