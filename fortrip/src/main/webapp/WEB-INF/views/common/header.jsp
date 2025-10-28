<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 10월 24일 taglib 추가 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 깔끔한 한글 가독성 -->
<link rel="preconnect" href="https://cdn.jsdelivr.net" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/static/pretendard.css" />

<link rel="stylesheet" href="/resources/css/common/header.css">

<header class="kr-header" role="banner">
  <div class="container">
    <!-- 로고 -->
    <h1 class="logo">
      <a href="/" aria-label="홈">
        <img src="/resources/img/common/eyes-in-icon.png" alt="fortrip" />
      </a>
    </h1>

    <!-- GNB -->
    <nav class="nav" role="navigation" aria-label="주요 메뉴">
      <ul class="nav-menu">
        <!-- 여행코스 -->
        <li class="nav-item">
          <a href="/trip/course" class="nav-link">여행코스</a>
          <ul class="dropdown">
            <li><a href="/trip/course">여행코스</a></li>
            <li><a href="/trip/course?tab=bestAdmin">관리자 추천 코스</a></li>
            <li><a href="/trip/course?tab=bestUser">사용자 추천 코스</a></li>
            <li><a href="/trip/course?tab=season">계절 추천 코스</a></li>
            <li><a href="/trip/course?tab=tourInfo">관광지 정보</a></li>            
          </ul>
        </li>

        <!-- 나만의 로드맵 -->
        <li class="nav-item">
          <a href="/roadmap/my" class="nav-link">나만의 로드맵</a>
          <ul class="dropdown">
            <li><a href="/roadmap/my">나만의 로드맵</a></li>
          </ul>
        </li>

        <!-- 커뮤니티 -->
        <li class="nav-item">
          <a href="/board/free/list" class="nav-link">커뮤니티</a>
          <ul class="dropdown">
          	<!-- 서브네비 추가하시면 됩니다 -->
            <li><a href="#">???</a></li>
          </ul>
        </li>

        <!-- 고객지원 -->
        <li class="nav-item">
          <a href="/board/notice/list" class="nav-link">고객지원</a>
          <ul class="dropdown">
          	<!-- 서브네비 추가하시면 됩니다 -->
            <li><a href="#">Notices</a></li>
          </ul>
        </li>
      </ul>
    </nav>

    <!-- 검색 + 유저 -->
    <div class="right">
      <form action="/search" method="get" class="search" role="search">
        <svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="q" placeholder="여행지, 맛집 검색" />
      </form>

      <div class="user">
        <c:choose>
          <c:when test="${empty sessionScope.loginMember}">
            <a href="<c:url value='/member/login'/>" class="link">로그인</a>
            <span class="sep">·</span>
            <a href="<c:url value='/member/signup'/>" class="link">회원가입</a>
          </c:when>
          <c:otherwise>
            <a href="<c:url value='/member/mypage'/>" class="link welcome">${sessionScope.loginMember.nickName} 님</a>
            <span class="sep">·</span>
            <a href="<c:url value='/member/logout'/>" class="link">로그아웃</a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </div>
</header>