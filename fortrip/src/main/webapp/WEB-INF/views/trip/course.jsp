<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행코스 | FORTRIP</title>
<link rel="stylesheet" href="../resources/css/trip/course.css">
</head>
<body>
<div class="page-container">

  <!-- 왼쪽 사이드 메뉴 -->
  <aside class="sidebar">
    <ul>
      <li class="active"><a href="/trip/course">여행코스</a></li>
      <li><a href="/roadmap/my">나만의 로드맵</a></li>
      <li><a href="/recommend/user">사용자 추천</a></li>
      <li><a href="/info">관광지 정보</a></li>
    </ul>
  </aside>

  <!-- 메인 컨텐츠 -->
  <main class="content">

    <!-- 🔹 상단 여행 검색 필터 박스 -->
    <div class="trip-search-box">
      <h2>완벽한 여행을 찾아보세요</h2>
      <form action="${pageContext.request.contextPath}/trip/search" method="get" class="search-form">

        <div class="search-row">
          <div class="field">
            <label>목적지</label>
            <div class="input-wrap">
              <span class="icon">📍</span>
              <input type="text" name="destination" placeholder="어디로 가시나요?" />
            </div>
          </div>

          <div class="field">
            <label>체크인</label>
            <div class="input-wrap">
              <span class="icon">📅</span>
              <input type="date" name="checkin" />
            </div>
          </div>

          <div class="field">
            <label>체크아웃</label>
            <div class="input-wrap">
              <span class="icon">📅</span>
              <input type="date" name="checkout" />
            </div>
          </div>

          <div class="field">
            <label>인원</label>
            <div class="input-wrap">
              <span class="icon">👤</span>
              <input type="text" name="people" placeholder="1명" />
            </div>
          </div>

          <div class="field btn-field">
            <button type="submit">🔍 검색</button>
          </div>
        </div>

        <div class="filter-link">
          <a href="#">⚙ 고급 필터</a>
        </div>
      </form>
    </div>

    <!-- 🔹 여행코스 카드 -->
    <h1>여행코스</h1>
    <p class="subtitle">전문가와 여행자들이 추천하는 최고의 여행코스를 만나보세요</p>

    <div class="course-card">
      <div class="card-img"></div>
      <h3>서울 도심문화 코스</h3>
      <div class="card-info">
        <div class="card-header">
          <span>경복궁</span> →
          <span>북촌한옥마을</span> →
          <span>인사동</span> →
          <span>명동</span>
        </div>
        <div class="card-main">
          <div class="card-item">
            <span class="material-symbols-outlined"><img src="../../../resources/img/trip/distance.png"></span>
            <span>서울</span>
          </div>
          <div class="card-item">
            <span class="material-symbols-outlined"><img src="../../../resources/img/trip/schedule.png"></span>
            <span>6시간</span>
          </div>
          <div class="card-item">
            <span class="material-symbols-outlined"><img src="../../../resources/img/trip/star.png"></span>
            <span>4.9</span>
          </div>
          <div class="card-item">
            <span class="material-symbols-outlined"><img src="../../../resources/img/trip/card.png"></span>
            <span>50,000￦</span>
          </div>
        </div>
        <div class="card-footer">
          <span class="card-date">2025.10.25 등록</span>
        </div>
      </div>
    </div>

    <!-- 🔹 사용자 추천 섹션 -->
    <section class="user-recommend">
      <h2>당신만을 위한 사용자 추천 특별한 여행</h2>
      <p>모든 경험이 담긴 특별한 여행을 지금 바로 만나보세요!</p>
      <button>지금부터 찾아보기</button>
    </section>
  </main>
</div>
</body>
</html>
