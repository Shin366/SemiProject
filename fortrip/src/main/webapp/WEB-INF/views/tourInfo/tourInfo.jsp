<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com"><link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700;900&display=swap" rel="stylesheet">

  <style>
    :root{
      --bg:#f6f7fb;
      --card:#ffffff;
      --border:#e5e9f0;
      --line:#e9eef3;
      --text:#0f172a;
      --muted:#6b7280;
      --muted-2:#9aa3af;
      --primary:#2563eb;
      --primary-weak:#eef2ff;
      --accent:#0ea5e9;
      --danger:#ef4444;
      --shadow:0 10px 30px rgba(2,8,23,.06);
      --radius:18px;
      --radius-sm:12px;
      --radius-lg:22px;
      --sidebar-w:220px;
      --header-h:68px;
    }
    *{box-sizing:border-box}
    html,body{height:100%}
    body{
      margin:0; background:var(--bg); color:var(--text);
      font-family:"Noto Sans KR", system-ui, -apple-system, Segoe UI, Roboto, "Helvetica Neue", Arial, "Apple SD Gothic Neo", "Malgun Gothic", sans-serif;
      letter-spacing:-.2px;
    }

    /* 헤더 */
    .header{
      position:sticky; top:0; z-index:50;
      height:var(--header-h); background:#fff; border-bottom:1px solid var(--line);
      display:flex; align-items:center; gap:18px; padding:0 20px 0 14px;
    }
    .brand{
      display:flex; align-items:center; gap:10px; text-decoration:none; color:inherit;
    }
    .brand-badge{
      width:54px; height:54px; border-radius:50%;
      background:radial-gradient(84% 84% at 24% 22%, #fff 0 30%, #c7e1ff 60%, #9cc7ff 100%);
      display:grid; place-items:center; box-shadow:0 6px 14px rgba(37,99,235,.15) inset;
      border:1px solid #dce7ff;
    }
    .brand-badge b{ font-weight:900; color:#111; font-size:14px; }
    .brand-title{
      font-weight:900; font-size:22px; letter-spacing:.2px; display:flex; align-items:baseline; gap:6px;
    }
    .brand-title small{ font-weight:700; color:var(--muted); font-size:12px }
    .gnb{ display:flex; gap:24px; margin-left:10px }
    .gnb a{
      text-decoration:none; color:#1f2937; font-weight:600; font-size:15px; padding:10px 2px; border-bottom:2px solid transparent;
    }
    .gnb a:hover{ color:var(--primary) }
    .gnb a.is-active{ color:var(--primary); border-color:var(--primary) }

    .header-spacer{ flex:1 }

    .searchbar{
      width:420px; max-width:36vw; display:flex; align-items:center; gap:10px;
      background:#f3f5f9; border:1px solid var(--border); border-radius:999px; padding:10px 14px;
    }
    .searchbar svg{ width:18px; height:18px; color:#64748b }
    .searchbar input{
      border:0; outline:0; background:transparent; width:100%; font-size:14px; color:#111;
    }
    .btn{
      height:38px; border-radius:999px; padding:0 18px; border:1px solid var(--border);
      background:#fff; font-weight:700; font-size:14px; cursor:pointer;
    }
    .btn.primary{ background:var(--primary); color:#fff; border-color:var(--primary) }
    .btn.primary:hover{ filter:brightness(.98) }
    .btn:active{ transform:translateY(1px) }

    /* 레이아웃 */
    .wrap{
      display:grid; grid-template-columns: var(--sidebar-w) 1fr; min-height:calc(100% - var(--header-h));
    }

    /* 사이드바 */
    .sidebar{
      border-right:1px solid var(--line); background:#fff;
      padding:18px 14px; position:sticky; top:var(--header-h); height:calc(100vh - var(--header-h));
    }
    .s-title{ font-weight:800; color:#111; font-size:14px; opacity:.7; padding:6px 8px }
    .s-menu{ display:flex; flex-direction:column; gap:8px; margin-top:6px }
    .s-item{
      display:flex; align-items:center; gap:10px;
      padding:11px 12px; border-radius:12px; text-decoration:none; color:#0f172a; font-weight:600; font-size:14px;
    }
    .s-item:hover{ background:#f6f8ff }
    .s-item svg{ width:18px; height:18px; color:#6b7280 }
    .s-item.active{ background:var(--primary-weak); color:#1d4ed8; border:1px solid #dbe6ff }

    /* 메인 컨텐트 */
    .content{ padding:28px 28px 56px }
    .hero{
      background:linear-gradient(180deg, #eef2ff 0%, #e5f4ff 100%);
      border:1px solid #dfe7ff; border-radius:var(--radius-lg);
      padding:38px 36px; box-shadow:var(--shadow);
    }
    .hero h1{
      margin:0 0 8px; font-size:26px; font-weight:900; letter-spacing:-.3px; color:#0b1324;
    }
    .hero p{ margin:0; color:#4b5563; font-size:14px }
    .inline-search{
      margin:22px auto 0; max-width:640px;
      display:flex; gap:10px; align-items:center; padding:10px 14px;
      background:#fff; border:1px solid var(--border); border-radius:999px; box-shadow:0 8px 24px rgba(2,8,23,.04);
    }
    .inline-search svg{ width:18px; height:18px; color:#64748b }
    .inline-search input{
      border:0; outline:0; width:100%; font-size:14px; background:transparent;
    }

    /* 리스트 */
    .section-title{ margin:26px 2px 18px; font-weight:800; color:#111; font-size:16px }
    .grid{
      display:grid; grid-template-columns:repeat(12, 1fr); gap:18px;
    }
    .card{
      grid-column: span 4;
      background:var(--card); border:1px solid var(--line); border-radius:var(--radius);
      overflow:hidden; box-shadow:var(--shadow); transition:transform .2s ease, box-shadow .2s ease, border-color .2s ease;
    }
    .card:hover{ transform:translateY(-3px); box-shadow:0 18px 40px rgba(2,8,23,.08); border-color:#dfe7ff }
    .thumb{ aspect-ratio: 16/10; width:100%; object-fit:cover; display:block }
    .card-body{ padding:14px 14px 12px }
    .title-row{
      display:flex; align-items:center; justify-content:space-between; gap:10px; margin-bottom:8px;
    }
    .place{ font-weight:800; font-size:15px }
    .like{
      display:inline-flex; align-items:center; gap:6px; font-size:12px; color:#ef4444; background:#fff5f5;
      border:1px solid #ffd7d7; padding:6px 8px; border-radius:999px;
    }
    .info{
      display:grid; gap:6px; font-size:12.5px; color:#6b7280
    }
    .info-row{ display:flex; align-items:flex-start; gap:8px }
    .info-row svg{ min-width:16px; height:16px; color:#9aa3af }
    .date{ margin-top:10px; font-size:11.5px; color:#9aa3af }

    /* 유틸 */
    .sr-only{ position:absolute; width:1px; height:1px; padding:0; margin:-1px; overflow:hidden; clip:rect(0,0,0,0); white-space:nowrap; border:0 }
    .divider{ height:1px; background:var(--line); margin:16px 0 }

    /* 반응형 */
    @media (max-width:1200px){
      .card{ grid-column: span 6; }
      .searchbar{ max-width:44vw }
    }
    @media (max-width:980px){
      .wrap{ grid-template-columns: 1fr }
      .sidebar{ position:static; height:auto; border-right:0; border-bottom:1px solid var(--line) }
      .card{ grid-column: span 6; }
      .searchbar{ display:none }
    }
    @media (max-width:640px){
      .gnb{ display:none }
      .card{ grid-column: span 12; }
      .inline-search{ width:100% }
      .brand-badge{ width:46px; height:46px }
      .brand-title{ font-size:20px }
      .btn{ height:36px }
    }
  </style>
</head>
<body>
	<header class="header">
    <a class="brand" href="#">
      <span class="brand-badge" aria-hidden="true"><b>for</b></span>
      <span class="brand-title">fortrip <small>여행 플랫폼</small></span>
    </a>

    <nav class="gnb" aria-label="주요 메뉴">
      <a href="#" class="is-active">여행코스</a>
      <a href="#">나만의 로드맵</a>
      <a href="#">커뮤니티</a>
      <a href="#">리뷰</a>
    </nav>

    <div class="header-spacer"></div>

    <label class="searchbar" aria-label="통합 검색">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <circle cx="11" cy="11" r="7"></circle>
        <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
      </svg>
      <input type="search" placeholder="여행지, 맛집을 검색하세요" />
    </label>

    <button class="btn" type="button">00님 환영합니다</button>
    <button class="btn primary" type="button">로그인</button>
  </header>

  <main class="wrap">
    <!-- 사이드바 -->
    <aside class="sidebar">
      <div class="s-title">탐색</div>
      <nav class="s-menu">
        <a class="s-item" href="#">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M3 9l9-7 9 7"></path><path d="M9 22V12h6v10"></path>
          </svg>
          여행코스
        </a>
        <a class="s-item" href="#">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M3 6h18M3 12h18M3 18h18"></path>
          </svg>
          나만의 로드맵
        </a>
        <a class="s-item active" href="#">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10"></circle><path d="M8 12h8"></path>
          </svg>
          맞춤 여행 추천
        </a>
        <a class="s-item" href="#">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M21 10H7"></path><path d="M21 6H3"></path><path d="M21 14H3"></path><path d="M21 18H7"></path>
          </svg>
          관광지 정보
        </a>
      </nav>
    </aside>

    <!-- 메인 -->
    <section class="content">
      <div class="hero">
        <h1>대한민국의 아름다운 관광지</h1>
        <p>전국 각지의 숨겨진 명소와 인기 관광지를 발견해보세요</p>
        <label class="inline-search" aria-label="지역 검색">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="11" cy="11" r="7"></circle>
            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
          </svg>
          <input id="regionSearch" type="search" placeholder="지역명을 검색해 주세요" />
        </label>
      </div>

      <h2 class="section-title">추천 관광지</h2>

      <div id="cards" class="grid">
        <!-- 카드 반복 -->
        <!-- 카드 템플릿은 JS에서도 복제 가능하도록 data-attrs 사용 -->
      </div>
    </section>
  </main>

  <template id="cardTemplate">
    <article class="card" data-name="">
      <img class="thumb" src="" alt="">
      <div class="card-body">
        <div class="title-row">
          <div class="place">안동 하회 마을</div>
          <span class="like" aria-label="관심 수">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-.99-.99a5.5 5.5 0 1 0-7.78 7.78L12 21.23l8.77-8.77a5.5 5.5 0 0 0 .07-7.85z"></path>
            </svg>
            1,284
          </span>
        </div>

        <div class="info">
          <div class="info-row">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 10c0 5.5-9 12-9 12S3 15.5 3 10a9 9 0 1 1 18 0z"></path>
              <circle cx="12" cy="10" r="3"></circle>
            </svg>
            <span class="addr">경북 안동시 풍천면 전서로 186</span>
          </div>
          <div class="info-row">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="10"></circle><path d="M12 6v6l4 2"></path>
            </svg>
            <span class="time">AM 09 ~ PM 18</span>
            <span style="margin-left:8px">￦ 5,000 원</span>
          </div>
          <div class="info-row">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M22 16.92V21a2 2 0 0 1-2.18 2A19.79 19.79 0 0 1 3 6.18 2 2 0 0 1 5 4h4.09"></path>
              <path d="M15 3h6v6"></path><path d="M10 14a9 9 0 0 0 7 7"></path>
            </svg>
            <span class="tel">054-852-3588</span>
          </div>
        </div>

        <div class="date">2025.10.11 등록</div>
      </div>
    </article>
  </template>

  <script>
    // 더미 데이터 (이미지/이름만 달리하여 8개 렌더)
    const places = Array.from({length:8}).map((_,i)=>({
      name:"안동 하회 마을",
      addr:"경북 안동시 풍천면 전서로 186",
      time:"AM 09 ~ PM 18",
      price:"5,000",
      tel:"054-852-3588",
      date:["10.11","10.18","10.19","10.21","10.22","10.23","10.28","10.31"][i%8],
      // Unsplash의 비상업용 샘플 이미지 (랜덤 쿼리로 다양성)
      img:`https://images.unsplash.com/photo-1528909514045-2fa4ac7a08ba?q=80&w=1200&auto=format&fit=crop`,
      like: 1200 + Math.floor(Math.random()*200),
      region:["안동","경북","하회","전서"][i%4]
    }));

    const $cards = document.getElementById('cards');
    const $tpl = document.getElementById('cardTemplate');

    function render(list){
      $cards.innerHTML = '';
      list.forEach(p=>{
        const node = $tpl.content.firstElementChild.cloneNode(true);
        node.dataset.name = p.region;
        node.querySelector('.thumb').src = p.img;
        node.querySelector('.thumb').alt = `${p.name} 이미지`;
        node.querySelector('.place').textContent = p.name;
        node.querySelector('.addr').textContent = p.addr;
        node.querySelector('.time').textContent = p.time;
        node.querySelector('.tel').textContent = p.tel;
        node.querySelector('.date').textContent = `2025.${p.date} 등록`;
        node.querySelector('.like').lastChild.textContent = ' ' + p.like.toLocaleString();
        $cards.appendChild(node);
      });
    }
    render(places);

    // 지역 검색(간단 필터)
    const $region = document.getElementById('regionSearch');
    $region.addEventListener('input', e=>{
      const q = e.target.value.trim();
      if(!q){ render(places); return; }
      const filtered = places.filter(p => 
        p.name.includes(q) || p.addr.includes(q) || p.region.includes(q)
      );
      render(filtered);
    });
  </script>

</body>
</html>