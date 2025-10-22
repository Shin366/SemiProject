<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <li><a href="/community">커뮤니티</a></li>
        <li><a href="/support">고객지원</a></li>
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

    <!-- 로그인 / 회원가입 -->
    <div class="user-menu">
      <a href="/login">로그인</a>
      <a href="/register">회원가입</a>
    </div>
  </div>
</header>