<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>나만의 로드맵 - ForTrip</title>
<link rel="stylesheet" href="../resources/css/myroad/roadmain.css">
</head>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<div class="page-container">
  <!-- 왼쪽 메뉴 -->
  <aside class="sidebar">
    <ul>
      <li><a href="/trip/course">여행코스</a></li>
      <li class="active"><a href="/roadmap/my">나만의 로드맵</a></li>
      <li><a href="/roadmap/my">맞춤 여행 추천</a></li>
      <li><a href="/info">관광지 정보</a></li>
    </ul>
  </aside>

  <!-- 메인 -->
  <main class="content">
    <h1>나만의 로드맵</h1>

    <div class="roadmap-list">
      <div class="roadmap-card">
        <div class="thumbnail"></div>
        <div class="info">
          <span class="badge">로드맵</span>
          <div class="title">제주도 3박 4일 완전 정복 후기! 숨은 명소까지</div>
          <div class="meta">
            <span>2025년 3월 16일</span>
            <span>♥ 156</span>
            <span>💬 42</span>
            <span>👁 2,145</span>
          </div>
        </div>
        <div class="actions">
          <a href="#">수정하기</a>
          <a href="#">삭제하기</a>
        </div>
      </div>

      <div class="roadmap-card">
        <div class="thumbnail"></div>
        <div class="info">
          <span class="badge">로드맵</span>
          <div class="title">제주도 3박 4일 완전 정복 후기! 숨은 명소까지</div>
          <div class="meta">
            <span>2025년 3월 16일</span>
            <span>♥ 156</span>
            <span>💬 42</span>
            <span>👁 2,145</span>
          </div>
        </div>
        <div class="actions">
          <a href="#">수정하기</a>
          <a href="#">삭제하기</a>
        </div>
      </div>
    </div>

    <div class="pagination">
      <button>1</button>
      <button>2</button>
    </div>

    <button class="new-btn" onclick="location.href='trip/tripAdd'">새 로드맵 만들기</button>
  </main>
</div>
</body>
</html>

