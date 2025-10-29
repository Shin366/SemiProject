<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>여행코스자세히보기</title>
  <!-- 기존 공통 CSS가 있다면 유지 -->
  <link rel="stylesheet" href="/resources/css/common/header.css">
  <!-- 페이지 전용 스타일 -->
  <style>
    :root{
      --bg:#fafafa;
      --card:#ffffff;
      --border:#e9eef3;
      --text:#0f172a;
      --muted:#6b7280;
      --primary:#2563eb;
      --primary-weak:#eff6ff;
      --accent:#0ea5e9;
      --like:#ef4444;
      --shadow:0 8px 30px rgba(2,8,23,.06);
      --radius:16px;
    }
    *{box-sizing:border-box}
    html,body{height:100%}
    body{
      margin:0;
      background:var(--bg);
      color:var(--text);
      font-family:ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Noto Sans KR, Apple SD Gothic Neo, "Malgun Gothic", Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji";
      line-height:1.5;
    }

    /* 레이아웃 */
    .page{
      max-width:1280px;
      margin:24px auto 80px;
      padding:0 20px;
      display:grid;
      grid-template-columns: 220px 1fr 320px;
      gap:28px;
    }

    /* 사이드바 */
    .sidebar{
      position:sticky;
      top:88px;
      align-self:start;
      background:var(--card);
      border:1px solid var(--border);
      border-radius:var(--radius);
      box-shadow:var(--shadow);
      padding:12px;
    }
    .sidebar h3{
      margin:8px 10px 4px;
      font-size:14px;
      color:var(--muted);
      letter-spacing:.02em
    }
    .menu{
      list-style:none;
      padding:6px;
      margin:0;
      display:flex;
      flex-direction:column;
      gap:6px;
    }
    .menu a{
      display:flex; align-items:center; gap:10px;
      padding:12px 12px;
      border-radius:12px;
      text-decoration:none;
      color:var(--text);
      border:1px solid transparent;
      transition:.2s ease;
      font-weight:600;
    }
    .menu a:hover{ background:#f6faff; border-color:#e6f0ff }
    .menu .active a{
      background:var(--primary-weak);
      color:var(--primary);
      border-color:#dbeafe;
    }
    .ico{
      width:18px;height:18px;display:inline-flex;align-items:center;justify-content:center
    }

    /* 메인 */
    .main{
      min-width:0;
    }
    .tags{
      margin:6px 0 10px;
      display:flex; gap:8px; flex-wrap:wrap
    }
    .tag{
      font-size:12px; color:var(--primary);
      background:var(--primary-weak);
      padding:6px 10px; border-radius:999px; border:1px solid #dbeafe
    }
    .title-row{
      display:flex; align-items:center; justify-content:space-between; gap:12px;
    }
    .title-row h1{
      font-size:24px; margin:0 0 8px 0
    }
    .btn-like{
      display:inline-flex; align-items:center; gap:8px;
      padding:10px 14px; border-radius:999px; border:1px solid var(--border);
      background:var(--card); cursor:pointer; font-weight:700;
      box-shadow:var(--shadow);
    }
    .btn-like .heart{ color:var(--like) }

    .hero{
      background:linear-gradient(180deg,#f3f7ff, #f1f5f9);
      height:220px; border-radius:16px;
      border:1px dashed #cbd5e1;
      display:flex; align-items:center; justify-content:center;
      color:#94a3b8;
      margin:14px 0 10px;
    }

    .author{
      display:flex; align-items:center; justify-content:space-between; gap:16px;
      padding:8px 4px 20px; border-bottom:1px solid var(--border);
    }
    .author .who{ display:flex; align-items:center; gap:12px }
    .avatar{
      width:36px;height:36px;border-radius:50%;
      background:linear-gradient(135deg,#dbeafe,#e9d5ff);
      border:1px solid var(--border);
    }
    .name{ font-weight:700 }
    .sub{ color:var(--muted); font-size:12px }
    .stats{ display:flex; align-items:center; gap:16px; color:var(--muted); font-size:13px }

    .card{
      background:var(--card);
      border:1px solid var(--border);
      border-radius:var(--radius);
      box-shadow:var(--shadow);
      padding:18px;
    }
    .section-title{
      margin:18px 0 10px; font-size:16px; font-weight:800;
    }

    /* 지도 플레이스홀더 */
    .map{
      height:220px; border:1px dashed #cbd5e1; border-radius:12px;
      display:flex; align-items:center; justify-content:center;
      color:#94a3b8; background:#f8fafc;
    }

    /* 타임라인 */
    .timeline{
      margin-top:12px;
      display:flex; flex-direction:column; gap:12px;
    }
    .tl-item{
      position:relative; padding-left:32px;
      background:var(--card);
      border:1px solid var(--border);
      border-radius:14px; box-shadow:var(--shadow);
      padding:14px 16px 12px 40px;
    }
    .tl-item::before{
      content:""; position:absolute; left:18px; top:16px;
      width:10px;height:10px; background:var(--primary); border-radius:50%;
      box-shadow:0 0 0 4px #e0edff;
    }
    .tl-head{
      display:flex; align-items:center; justify-content:space-between; gap:12px;
      margin-bottom:4px;
    }
    .tl-day{ font-weight:800; color:var(--text) }
    .tl-date{ font-size:12px; color:var(--muted) }
    .tl-body{ color:#334155; font-size:14px }
    .chips{ display:flex; gap:6px; margin-top:8px }
    .chip{
      font-size:11px; padding:4px 8px; border-radius:999px; border:1px solid var(--border);
      background:#f8fafc; color:#475569
    }
    .time{ font-size:12px; color:var(--muted); margin-top:6px }

    /* 우측 정보 패널 */
    .right{
      position:sticky; top:88px; align-self:start;
      display:flex; flex-direction:column; gap:14px;
    }
    .info-card .row{
      display:flex; justify-content:space-between; padding:10px 0;
      border-bottom:1px dashed var(--border);
      font-size:14px;
    }
    .info-card .row:last-child{ border-bottom:0 }
    .key{ color:var(--muted) }
    .val{ font-weight:700 }

    /* 반응형 */
    @media (max-width:1100px){
      .page{ grid-template-columns: 200px 1fr; }
      .right{ display:none; }
    }
    @media (max-width:820px){
      .page{ grid-template-columns: 1fr; }
      .sidebar{ position:relative; top:auto; }
    }
  </style>
</head>
<body>
  <!-- 공통 헤더 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp"/>

  <div class="page">

    <!-- 사이드바 -->
    <aside class="sidebar" aria-label="여행 메뉴">
      <h3>여행코스</h3>
      <ul class="menu">
        <li class="active">
          <a href="/trip/course">
            <span class="ico" aria-hidden="true">
              <!-- map pin -->
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4.5 8-11a8 8 0 1 0-16 0c0 6.5 8 11 8 11z"/><circle cx="12" cy="11" r="3"/></svg>
            </span>
            여행코스
          </a>
        </li>
        <li>
          <a href="/roadmap/my">
            <span class="ico" aria-hidden="true">
              <!-- route -->
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h5a7 7 0 0 1 7 7v0a2 2 0 0 0 2 2h4"/><circle cx="6" cy="6" r="2"/><circle cx="18" cy="18" r="2"/></svg>
            </span>
            나만의 로드맵
          </a>
        </li>
        <li>
          <a href="/recommend/user">
            <span class="ico" aria-hidden="true">
              <!-- stars -->
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><path d="m12 17 5 3-1.9-5.5L20 10l-5.8-.2L12 4l-2.2 5.8L4 10l4.9 4.5L7 20z"/></svg>
            </span>
            사용자 추천
          </a>
        </li>
        <li>
          <a href="/info">
            <span class="ico" aria-hidden="true">
              <!-- info -->
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 8h.01M11 12h2v4h-2z"/></svg>
            </span>
            관광지 정보
          </a>
        </li>
      </ul>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="main">
      <div class="tags">
        <span class="tag">#먹방코스</span>
        <span class="tag">#부산코스</span>
      </div>

      <div class="title-row">
        <h1>부산 2박 3일 먹방 여행코스</h1>
        <button type="button" class="btn-like">
          <span class="heart" aria-hidden="true">❤</span> 찜하기
        </button>
      </div>

      <div class="hero">대표 이미지</div>

      <div class="author">
        <div class="who">
          <div class="avatar" aria-hidden="true"></div>
          <div>
            <div class="name">사용자(이름) 및 관리자</div>
            <div class="sub">닉네임</div>
          </div>
        </div>
        <div class="stats" aria-label="콘텐츠 통계">
          <span>❤ 156</span>
          <span>💬 42</span>
          <span>👁 2,145</span>
        </div>
      </div>

      <h3 class="section-title">코스소개</h3>
      <section class="card">
        부산의 대표적인 관광지를 중심으로 맛집을 잇는 2박 3일 먹방코스입니다. 계절과 날씨에 따라 변동될 수 있으며,
        상세한 운영시간과 휴무, 그리고 부산 맛집의 웨이팅을 고려할 수 있는 핵심 정보를 함께 제공합니다.
      </section>

      <h3 class="section-title">지도</h3>
      <section class="card">
        <div class="map">1, 2, 3 숫자로 표시하며 순서대로 정보 표시</div>
      </section>

      <h3 class="section-title">상세 일정</h3>
      <div class="timeline">
        <!-- Day 1 -->
        <article class="tl-item">
          <div class="tl-head">
            <div class="tl-day">Day 1 - 부자재시장</div>
            <div class="tl-date">2025.10.11</div>
          </div>
          <div class="tl-body">
            자갈치시장 → 자갈치 → 부산 영도 원정
            <div class="chips">
              <span class="chip">해산물</span>
              <span class="chip">시장투어</span>
            </div>
            <div class="time">오전 10:32 ~ 오후 12:20</div>
          </div>
        </article>

        <!-- Day 2 -->
        <article class="tl-item">
          <div class="tl-head">
            <div class="tl-day">Day 2 - 서구광복탐방</div>
            <div class="tl-date">2025.10.12</div>
          </div>
          <div class="tl-body">
            원도 18번 관음 → 송정동 → 선어 마을
            <div class="chips">
              <span class="chip">맛집</span>
              <span class="chip">카페</span>
            </div>
            <div class="time">오전 10:32 ~ 오후 12:20</div>
          </div>
        </article>

        <!-- Day 3 -->
        <article class="tl-item">
          <div class="tl-head">
            <div class="tl-day">Day 3 - 해운대구 맛집탐방</div>
            <div class="tl-date">2025.10.13</div>
          </div>
          <div class="tl-body">
            원도 18번 관음 → 송정동 → 선어 마을
            <div class="chips">
              <span class="chip">해운대</span>
              <span class="chip">포토스팟</span>
            </div>
            <div class="time">오전 10:32 ~ 오후 12:20</div>
          </div>
        </article>
      </div>
    </main>

    <!-- 우측 정보 패널 -->
    <aside class="right">
      <section class="card info-card" aria-labelledby="info-title">
        <h3 id="info-title" class="section-title" style="margin-top:0;">여행 정보</h3>
        <div class="row">
          <span class="key">총 기간</span>
          <span class="val">2025.10.11 ~ 2025.10.13</span>
        </div>
        <div class="row">
          <span class="key">비용</span>
          <span class="val">400,000원</span>
        </div>
        <div class="row">
          <span class="key">여행 스타일</span>
          <span class="val">먹방로드</span>
        </div>
      </section>
      <section class="card">
        <h3 class="section-title" style="margin-top:0;">유의사항</h3>
        <p style="margin:0; color:#475569; font-size:14px">
          영업시간/휴무, 웨이팅은 방문 전 다시 확인해주세요. 기상 악화 시 일부 일정이 변경될 수 있습니다.
        </p>
      </section>
    </aside>

  </div>
</body>
</html>
