<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>ForTrip - 메인페이지</title>
   <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
	<link rel="stylesheet" href="/resources/css/common/header.css">
	<link rel="stylesheet" href="/resources/css/common/rset.css">
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f8f9fa;
      color: #333;
    }

    /* 헤더 */
    
    /* 히어로 영역 */
    .hero {
      background-color: #d9d9d9;
      text-align: center;
      padding: 100px 20px;
    }
    .hero h1 { font-size: 32px; font-weight: 800; margin-bottom: 10px; }
    .hero p { color: #555; font-size: 16px; margin-bottom: 30px; }
    .hero .btn-group button {
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 20px;
      padding: 10px 20px;
      margin: 0 8px;
      cursor: pointer;
    }

    /* 카테고리 */
    .categories {
      display: flex;
      justify-content: center;
      flex-wrap: wrap;
      gap: 30px;
      background-color: #fff;
      padding: 40px 0;
    }
    .category {
      text-align: center;
      color: #555;
    }
    .category-circle {
      width: 70px; height: 70px;
      background-color: #e9eef5;
      border-radius: 50%;
      margin-bottom: 10px;
    }

    /* 인기 여행 코스 */
    .popular-section {
      max-width: 1200px;
      margin: 60px auto;
      padding: 0 20px;
    }
    .popular-section h2 {
      font-size: 24px;
      font-weight: 700;
      margin-bottom: 10px;
    }
    .popular-section p { color: #666; margin-bottom: 30px; }
    .course-list {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 20px;
    }
    .course-card {
      background-color: #f1f5f9;
      border-radius: 10px;
      padding: 20px;
      height: 220px;
    }
    .more-btn {
      display: block;
      text-align: center;
      background-color: #2563eb;
      color: #fff;
      font-weight: 600;
      padding: 12px 30px;
      border-radius: 8px;
      width: fit-content;
      margin: 40px auto;
      text-decoration: none;
    }

    /* 슬라이드 */
    .recommend {
      text-align: center;
      margin-top: 80px;
    }
    .circle-slide {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 40px;
      margin: 40px 0;
    }
    .circle {
      width: 90px; height: 90px;
      background: #e5e7eb;
      border-radius: 50%;
      line-height: 90px;
      font-weight: 500;
    }

    /* 포토스팟 / 가이드 */
    .photo-guide {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 40px;
      max-width: 1200px;
      margin: 80px auto;
      padding: 0 20px;
    }
    .photo, .guide { background: #f1f5f9; border-radius: 10px; padding: 30px; }

    .guide h3 { font-size: 22px; font-weight: 700; margin-bottom: 15px; }
    .guide p { color: #666; margin-bottom: 25px; }
    .guide-icons { display: flex; gap: 20px; }
    .guide-icons div {
      width: 70px; height: 70px;
      background: #e9eef5; border-radius: 50%;
      text-align: center; line-height: 70px; font-size: 14px;
    }

    footer {
      text-align: center;
      color: #888;
      padding: 30px 0;
      background: #fff;
      margin-top: 80px;
    }
  </style>
</head>
<body>
  <!-- Header -->
  <jsp:include page="/WEB-INF/views/common/header.jsp"/>

  <!-- Hero -->
  <section class="hero">
    <h1>대한민국 여행의 모든 것</h1>
    <p>전국 곳곳의 숨겨진 명소와 맛집을 발견하고, 나만의 여행 코스를 만들고 공유해보세요!</p>
    <div class="btn-group">
      <button>여행코스 보기</button>
      <button>지도에서 찾기</button>
    </div>
  </section>

  <!-- Categories -->
  <section class="categories">
    <div class="category"><div class="category-circle"></div><p>자연/강산</p></div>
    <div class="category"><div class="category-circle"></div><p>문화유적</p></div>
    <div class="category"><div class="category-circle"></div><p>맛집탐방</p></div>
    <div class="category"><div class="category-circle"></div><p>포토스팟</p></div>
    <div class="category"><div class="category-circle"></div><p>해변/섬</p></div>
    <div class="category"><div class="category-circle"></div><p>힐링여행</p></div>
    <div class="category"><div class="category-circle"></div><p>쇼핑</p></div>
    <div class="category"><div class="category-circle"></div><p>축제/행사</p></div>
  </section>

  <!-- Popular Courses -->
  <section class="popular-section">
    <h2>인기 여행 코스</h2>
    <p>여행자들이 가장 많이 선택한 추천 코스를 만나보세요</p>
    <div class="course-list">
      <div class="course-card"></div>
      <div class="course-card"></div>
      <div class="course-card"></div>
    </div>
    <a href="#" class="more-btn">더 많은 코스 보기</a>
  </section>

  <!-- Recommendation -->
  <section class="recommend">
    <h2>이런 여행을 찾으셨나요?</h2>
    <p>국내 여행지별 가장 알찬 코스를 추천해드립니다!</p>
    <div class="circle-slide">
      <button>&lt;</button>
      <div class="circle">부산</div>
      <div class="circle">전주</div>
      <div class="circle">공주</div>
      <div class="circle">대전</div>
      <div class="circle">강릉</div>
      <button>&gt;</button>
    </div>
  </section>

  <!-- Photo & Guide -->
  <section class="photo-guide">
    <div class="photo">
      <h3>포토스팟</h3>
      <p>여행자들이 가장 많이 선택한 추천 코스를 만나보세요</p>
    </div>
    <div class="guide">
      <h3>for-trip 가이드</h3>
      <p>즐겁고 좋은 추억을 남기기 위한 정보를 알려드립니다!</p>
      <div class="guide-icons">
        <div>로드맵</div>
        <div>리뷰</div>
        <div>커뮤니티</div>
      </div>
    </div>
  </section>
  
  <!-- footer -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
