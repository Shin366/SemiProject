<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 10월 24일 taglib 추가 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/common/header.css">
<header class="site-header">
  <div class="container">
    <!-- 왼쪽 로고 -->
    <div class="logo">
      <a href="/">
        <img src="/resources/img/common/eyes-in-icon.png">
      </a>
    </div>

    <!-- 중앙 메뉴 -->
    <nav class="nav-menu">
      <ul>
		<li><a href="/trip/course">여행코스</a></li>
		<li><a href="/roadmap/my">나만의 로드맵</a></li>
        <li><a href="/board/free/list">커뮤니티</a></li>
        <li><a href="/board/notice/list">고객지원</a></li>
		<li><a href="/admin/main">관리자페이지</a></li>         
      </ul>
    </nav>

    <!-- 검색창 -->
    <div class="search-box">
      <form action="/search" method="get">
        <button type="submit" class="icon">🔍</button>
        <input type="text" name="q" placeholder="여행지, 맛집을 검색하세요" />
      </form>
    </div>

<!-- 10월 24일 로그인/ 로그인 후 구분해서 출력 수정 -->
    <!-- 로그인 -->
    <div class="user-menu">
	   <c:choose>
	        <c:when test="${empty sessionScope.loginMember}">
	         <!-- 로그인 전 -->
	          <a href="<c:url value='/member/login'/>" class="login-btn">로그인</a>
	          <a href="<c:url value='/member/signup'/>" class="signup-btn">회원가입</a>
	        </c:when>
	        <c:otherwise>
	          <!-- 로그인 후 -->
	          <!-- 닉네임 클릭시 마이페이지로 연결 -->
	         <a href="<c:url value='/member/mypage'/>" class="welcome-link"> 
		          <span class="welcome-text">
		            ${sessionScope.loginMember.nickName} 님 환영합니다
		          </span>
		      </a>
	          <a href="<c:url value='/member/logout'/>" class="logout-btn">로그아웃</a>
	        </c:otherwise>
	      </c:choose>
    </div>
  </div>
</header>