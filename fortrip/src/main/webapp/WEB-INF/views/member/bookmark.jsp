<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip -  내 북마크</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
</head>
<body>
	<div id="container">
    <main id="main">
        <!-- 사이드바 -->
        <div class="sidebar">
            <ul>
                <li><a href="/member/profile">내 프로필</a></li>
                <li><a href="/member/myBoard">내 게시글</a></li>
                <li><a href="/member/bookmark" class="active">찜 목록</a></li>
                <li><a href="/member/recent">최근 본 코스</a></li>
                <li><a href="/member/update">개인 정보 수정</a></li>
                <li><a href="/member/delete">회원탈퇴</a></li>
            </ul>
        </div>

        <!-- 메인 컨텐츠 -->
        <div class="myboard-container">
            <div class="myboard-header">
                <h2>내 북마크</h2>
                <p>총 북마크: ${bookmarkCount}</p>
            </div>

            <!-- 북마크 리스트 -->
			<div class="board-list">
			    <c:forEach var="b" items="${bookmarkList}">
			        <div class="bookmark-card" onclick="location.href='/${b.TARGET_TYPE == 'review' ? 'review/view?no=' : 'free/view?no='}${b.TARGET_NO}'">
			            
			            <!-- 게시글 분류 (리뷰 / 커뮤니티) -->
			            <span class="category">
			                <c:choose>
			                    <c:when test="${b.TARGET_TYPE == 'review'}">리뷰</c:when>
			                    <c:otherwise>커뮤니티</c:otherwise>
			                </c:choose>
			            </span>
			            
			            <!-- 제목 -->
			            <h3 class="title">${b.title}</h3>
			            
			            <!-- 작성일 -->
			            <p class="date">
			                <fmt:formatDate value="${b.writeDate}" pattern="yyyy년 MM월 dd일" />
			            </p>
			            
			            <!-- 삭제 버튼 -->
			            <div class="board-actions">
			                <a href="/member/bookmark/delete?bookmarkNo=${b.bookmarkNo}" 
			                   class="btn-delete"
			                   onclick="event.stopPropagation(); return confirm('정말 삭제하시겠습니까?')">
			                    삭제
			                </a>
			            </div>
			        </div>
			    </c:forEach>
			
			    <!-- 북마크 없을 때 -->
			    <c:if test="${empty bookmarkList}">
			        <div class="empty-state">
			            <p>저장한 북마크가 없습니다.</p>
			        </div>
			    </c:if>
			</div>
        </div>
    </main>
</div>
</body>
</html>