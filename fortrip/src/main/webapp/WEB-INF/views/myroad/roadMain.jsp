<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>나만의 로드맵 - ForTrip</title>
<style>
body {
  margin: 0;
  font-family: 'Noto Sans KR', sans-serif;
  background: #f5f5f5;
}

/* 전체 페이지 구조 */
.page-container {
  display: flex;
  min-height: 100vh;
}

/* 사이드바 */
.sidebar {
  width: 200px;
  background: #fff;
  border-right: 1px solid #ddd;
  padding-top: 20px;
}
.sidebar ul {
  list-style: none;
  margin: 0;
  padding: 0;
}
.sidebar li {
  margin-bottom: 10px;
}
.sidebar a {
  display: block;
  padding: 10px 15px;
  text-decoration: none;
  color: #333;
  border-radius: 4px;
}
.sidebar li.active a {
  background: #0066ff;
  color: #fff;
}

/* 메인 콘텐츠 */
.content {
  flex: 1;
  padding: 40px;
  background: #fff;
  margin: 20px;
  border-radius: 10px;
}
.content h1 {
  font-size: 22px;
  margin-bottom: 25px;
}

/* 로드맵 카드 리스트 */
.roadmap-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}
.roadmap-card {
  display: flex;
  background: #f9f9f9;
  border: 1px solid #ddd;
  border-radius: 10px;
  padding: 20px;
  align-items: flex-start;
}
.thumbnail {
  width: 180px;
  height: 120px;
  background: #dcdcdc;
  border-radius: 8px;
  margin-right: 20px;
}
.info {
  flex: 1;
}
.info .badge {
  display: inline-block;
  background: #eee;
  color: #555;
  font-size: 12px;
  padding: 3px 7px;
  border-radius: 5px;
}
.info .title {
  font-size: 18px;
  font-weight: 600;
  margin: 8px 0;
}
.info .meta {
  font-size: 13px;
  color: #777;
  margin-top: 6px;
  display: flex;
  gap: 15px;
  align-items: center;
}
.info .meta span {
  display: flex;
  align-items: center;
  gap: 4px;
}

.actions {
  text-align: right;
  font-size: 13px;
  color: #666;
}
.actions a {
  color: #666;
  text-decoration: none;
  margin-left: 10px;
}

/* 페이지 버튼 */
.pagination {
  text-align: center;
  margin-top: 30px;
}
.pagination button {
  border: 1px solid #ccc;
  background: #fff;
  padding: 5px 10px;
  margin: 0 3px;
  border-radius: 4px;
  cursor: pointer;
}
.pagination button:hover {
  background: #0066ff;
  color: #fff;
}

/* 새 로드맵 버튼 */
.new-btn {
  display: block;
  margin: 40px auto 0;
  padding: 10px 20px;
  background: #0066ff;
  color: #fff;
  border: none;
  border-radius: 20px;
  cursor: pointer;
}
</style>
</head>

<body>
<div class="page-container">
  <!-- 왼쪽 메뉴 -->
  <aside class="sidebar">
    <ul>
      <li><a href="#">여행코스</a></li>
      <li class="active"><a href="#">나만의 로드맵</a></li>
      <li><a href="#">맞춤 여행 추천</a></li>
      <li><a href="#">관광지 정보</a></li>
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

    <button class="new-btn">새 로드맵 만들기</button>
  </main>
</div>
</body>
</html>

