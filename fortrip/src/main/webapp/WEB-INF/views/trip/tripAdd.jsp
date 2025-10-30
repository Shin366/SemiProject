<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>코스 등록</title>

  <!-- 공통 헤더 CSS 유지 -->
  <link rel="stylesheet" href="../resources/css/common/header.css">
  <link rel="stylesheet" href="../resources/css/trip/tripAdd.css">
</head>
<body>
  <!-- 공통 헤더 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp"/>

  <div class="page">
    <!-- 사이드바 -->
    <aside class="sidebar">
      <ul>
        <li><a class="nav-btn" href="/trip/course">
          <span class="ico" aria-hidden="true"> <!-- SVG 그래픽을 담는 컨테이너임  -->
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4.5 8-11a8 8 0 1 0-16 0c0 6.5 8 11 8 11z"/><circle cx="12" cy="11" r="3"/></svg>
          </span> 여행코스
        </a></li>
        <li><a class="nav-btn" href="/roadmap/my">
          <span class="ico" aria-hidden="true">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h5a7 7 0 0 1 7 7v0a2 2 0 0 0 2 2h4"/><circle cx="6" cy="6" r="2"/><circle cx="18" cy="18" r="2"/></svg>
          </span> 나만의 로드맵
        </a></li>
        <li class="active"><a class="nav-btn" href="/recommend/user">
          <span class="ico" aria-hidden="true">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="m12 17 5 3-1.9-5.5L20 10l-5.8-.2L12 4l-2.2 5.8L4 10l4.9 4.5L7 20z"/></svg>
          </span> 맞춤 여행 추천
        </a></li>
        <li><a class="nav-btn" href="/info">
          <span class="ico" aria-hidden="true">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 8h.01M11 12h2v4h-2z"/></svg>
          </span> 관광지 정보
        </a></li>
      </ul>
    </aside>
    <!-- 메인 -->
    <main class="main">
      <form id="courseForm" class="card" method="post" action="/trip/course/insert" enctype="multipart/form-data">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <input type="hidden" name="itineraryJson" id="itineraryJson">
		<input type="hidden" name="routeCsv" id="routeCsv">
		
        <h2 class="section-title" style="margin-top:4px;">새 코스 만들기</h2>

        <!-- 기본 정보 -->
        <div class="form-grid">
          <div class="field">
            <label class="req">코스 제목</label> 
            <input type="text" name="title" placeholder="예) 봄맞이 부산 2박 3일 감성로드" required>
          </div>
          <div class="field">
            <label>메인사진</label>
            <div class="upload">
              <img id="thumbPreview" class="thumb" alt="사진 미리보기">
              <div>
                <input type="file" name="thumbnail" id="thumbnail" accept="image/*">
                <div class="hint">JPG/PNG 권장, 최대 5MB</div>
              </div>
            </div>
          </div>

          <div class="field">
            <label class="req">시작일</label>
            <input type="date" name="startDate" required>
          </div>
          <div class="field">
            <label class="req">종료일</label>
            <input type="date" name="endDate" required>
          </div>

          <div class="field">
            <label>코스 한줄 소개</label>
            <input type="text" name="slogan" placeholder="여행의 컨셉/한줄 소개">
          </div>
          <div class="field"></div>

          <div class="field">
            <label class="req">지역</label>
            <select name="region" required>
              <option value="">선택</option>
              <option>서울</option><option>인천</option><option>제주</option>
              <option>충청</option><option>전라</option><option>경기</option>
              <option>강원</option><option>경상</option>
            </select>
          </div>
          <div class="form-row">
            <div class="field" style="flex:1">
              <label class="req">총계 예산</label>
              <input type="number" name="budget" min="0" placeholder="금액">
            </div>
            <div class="field" style="width:140px">
              <label class="req">단위</label>
              <select name="budgetUnit">
                <option value="원">원</option>
                <option value="USD">USD</option>
              </select>
            </div>
          </div>
        </div>

        <!-- 테마 -->
        <div style="margin-top:12px">
          <label class="req">여행 스타일(복수선택)</label>
          <div id="themeChips" class="chips" style="margin-top:8px">
            <label class="chip"><input type="checkbox" name="themes" value="먹방코스">먹방코스</label>
            <label class="chip"><input type="checkbox" name="themes" value="국토대장정">국토대장정</label>
            <label class="chip"><input type="checkbox" name="themes" value="문화유적">문화/유적</label>
            <label class="chip"><input type="checkbox" name="themes" value="액티비티">액티비티</label>
            <label class="chip"><input type="checkbox" name="themes" value="쇼핑">쇼핑</label>
            <label class="chip"><input type="checkbox" name="themes" value="자전거">자전거</label>
            <label class="chip"><input type="checkbox" name="themes" value="포토스팟">포토스팟</label>
            <label class="chip"><input type="checkbox" name="themes" value="바다/섬">바다/섬</label>
            <label class="chip"><input type="checkbox" name="themes" value="산">산</label>
            <label class="chip"><input type="checkbox" name="themes" value="축제/행사">축제/행사</label>
            <label class="chip"><input type="checkbox" name="themes" value="자연/경관">자연/경관</label>
          </div>
        </div>

        <!-- 소개 & 지도 -->
        <div class="split" style="margin-top:12px">
          <div class="field">
            <label>코스소개</label>
            <textarea name="description" placeholder="여행 목적/하이라이트 등을 간단히 적어주세요."></textarea>
          </div>
          <!-- 우측 비워두기(필요시 다른 필드) -->
          <div class="field"></div>
          <!-- 전폭 지도 -->
          <div class="field map-field">
            <label>지도</label>
            <div id="map"></div>
            <div id="menu_wrap" class="bg_white">
	        <div class="option">
		            <div>
		                <div id="searchContainer"></div>
		            </div>
		        </div>
		        <hr>
		        <ul id="placesList" style="padding-left:0px;"></ul>
		        <div id="pagination"></div>
		    </div>
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=579c3fc0e58b4770da213c3378ba8797&libraries=services"></script>
            <script>
              // Kakao 기본 예제 코드 사용 + 안전가드만 추가
              var markers = [];
              var mapContainer = document.getElementById('map'),
                  mapOption = { center: new kakao.maps.LatLng(37.566826, 126.9786567), level: 3 };
              var map = new kakao.maps.Map(mapContainer, mapOption);
              var ps = new kakao.maps.services.Places();
              var infowindow = new kakao.maps.InfoWindow({zIndex:1});

              // 레이아웃 계산 후 중심 보정(그리드 내부일 때 위치 틀어짐 방지)
              function relayoutSafe(){
                var c = map.getCenter();
                map.relayout();
                map.setCenter(c);
              }
              window.addEventListener('load', function(){ setTimeout(relayoutSafe, 60); });
              window.addEventListener('resize', function(){ setTimeout(relayoutSafe, 60); });

           // searchContainer 안에 폼을 동적으로 생성
              const container = document.getElementById('searchContainer');

              const searchWrap = document.createElement('div');
              searchWrap.innerHTML = `
            	  키워드 :
            	  <input type="text" id="keyword" value="노원" size="15">
            	  <button type="button" id="btnKeywordSearch">검색하기</button>
            	`;

              searchContainer.appendChild(searchWrap);
              
           // 이벤트: 클릭/엔터로 검색
              document.getElementById('btnKeywordSearch').addEventListener('click', searchPlaces);
              document.getElementById('keyword').addEventListener('keydown', (e) => {
                if (e.key === 'Enter') {
                  e.preventDefault();
                  searchPlaces();
                }
              });
              // 초기 검색 호출 시 keyword 요소가 없으면 에러 → 방어
              // (원문 형식 유지)
              try { searchPlaces(); } catch(e) {}

              function searchPlaces() {
                  var kwEl = document.getElementById('keyword');
                  if(!kwEl){ return; } // 페이지에 검색창이 없을 때는 건너뜀
                  var keyword = kwEl.value;
                  if (!keyword.replace(/^\s+|\s+$/g, '')) {
                      alert('키워드를 입력해주세요!');
                      return false;
                  }
                  ps.keywordSearch(keyword, placesSearchCB);
              }

              function placesSearchCB(data, status, pagination) {
                  if (status === kakao.maps.services.Status.OK) {
                      displayPlaces(data);
                      displayPagination(pagination);
                  } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
                      alert('검색 결과가 존재하지 않습니다.');
                      return;
                  } else if (status === kakao.maps.services.Status.ERROR) {
                      alert('검색 결과 중 오류가 발생했습니다.');
                      return;
                  }
              }

              function displayPlaces(places) {
                  var listEl = document.getElementById('placesList'),
                      menuEl = document.getElementById('menu_wrap'),
                      fragment = document.createDocumentFragment(),
                      bounds = new kakao.maps.LatLngBounds();

                  if(listEl) removeAllChildNods(listEl);
                  removeMarker();

                  for ( var i=0; i<places.length; i++ ) {
                      var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
                          marker = addMarker(placePosition, i),
                          itemEl = getListItem(i, places[i]);
                      bounds.extend(placePosition);

                      (function(marker, title) {
                          kakao.maps.event.addListener(marker, 'mouseover', function() { displayInfowindow(marker, title); });
                          kakao.maps.event.addListener(marker, 'mouseout', function() { infowindow.close(); });
                          if(itemEl){
                            itemEl.onmouseover = function () { displayInfowindow(marker, title); };
                            itemEl.onmouseout  = function () { infowindow.close(); };
                          }
                      })(marker, places[i].place_name);

                      if(fragment && itemEl) fragment.appendChild(itemEl);
                  }

                  if(listEl && fragment) listEl.appendChild(fragment);
                  if(menuEl) menuEl.scrollTop = 0;

                  map.setBounds(bounds);
                  setTimeout(relayoutSafe, 30);
              }

              function getListItem(index, places) {
                  var el = document.getElementById('placesList') ? document.createElement('li') : null;
                  if(!el) return null;
                  var itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                                '<div class="info">' +
                                '   <h5 style="margin:0;font-size:12px;">' + places.place_name + '</h5>';
                  if (places.road_address_name) {
                      itemStr += '    <span>' + places.road_address_name + '</span>' +
                                 '   <span class="jibun gray">' +  places.address_name  + '</span>';
                  } else {
                      itemStr += '    <span>' +  places.address_name  + '</span>';
                  }
                  itemStr += '  <span class="tel">' + (places.phone || '')  + '</span>' +
                             '</div>';
                  el.innerHTML = itemStr;
                  el.className = 'item';
                  return el;
              }

              function addMarker(position, idx) {
                  var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png',
                      imageSize = new kakao.maps.Size(36, 37),
                      imgOptions =  {
                          spriteSize : new kakao.maps.Size(36, 691),
                          spriteOrigin : new kakao.maps.Point(0, (idx*46)+10),
                          offset: new kakao.maps.Point(13, 37)
                      },
                      markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
                      marker = new kakao.maps.Marker({ position: position, image: markerImage });

                  marker.setMap(map);
                  markers.push(marker);
                  return marker;
              }

              function removeMarker() { for ( var i = 0; i < markers.length; i++ ) { markers[i].setMap(null); } markers = []; }

              function displayPagination(pagination) {
                  var paginationEl = document.getElementById('pagination'),
                      fragment = document.createDocumentFragment(), i;
                  if(!paginationEl) return;

                  while (paginationEl.hasChildNodes()) { paginationEl.removeChild (paginationEl.lastChild); }
                  for (i=1; i<=pagination.last; i++) {
                      var el = document.createElement('a');
                      el.href = "#";
                      el.innerHTML = i;
                      if (i===pagination.current) { el.className = 'on'; }
                      else { el.onclick = (function(i) { return function() { pagination.gotoPage(i); } })(i); }
                      fragment.appendChild(el);
                  }
                  paginationEl.appendChild(fragment);
              }

              function displayInfowindow(marker, title) {
                  var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
                  infowindow.setContent(content);
                  infowindow.open(map, marker);
              }

              function removeAllChildNods(el) { while (el && el.hasChildNodes()) { el.removeChild (el.lastChild); } }
            </script>
          </div>
        </div>

        <!-- 장소 자동/수동 입력 -->
        <div class="card" style="margin-top:14px">
          <div class="form-row" style="align-items:center">
            <div class="field" style="flex:1">
              <label>장소 직접 입력 <span class="hint">(엔터로 복수추가)</span></label>
              <input id="placeInput" type="text" placeholder="예) 자갈치시장, 감천문화마을">
            </div>
            <!-- 버튼이 가로로 잘 보이도록 .btn에 nowrap/height 지정됨 -->
            <button type="button" class="btn btn-weak" id="btnAddDay">일차 추가</button>
            <button type="button" class="btn btn-weak" id="btnAddCategory">카테고리 추가</button>
          </div>

          <!-- 일정 빌더 -->
          <div id="builder" class="builder" style="margin-top:12px">
            <!-- Day blocks will be inserted here -->
          </div>

          <div class="toolbar">
            <button type="button" class="btn btn-danger" id="btnReset">초기화</button>
            <button type="submit" class="btn btn-primary">코스 등록</button>
          </div>
        </div>
      </form>
    </main>
  </div>

  <script>
    // ===== 썸네일 미리보기 =====
    const thumbInput = document.getElementById('thumbnail');
    const thumbPreview = document.getElementById('thumbPreview');
    if (thumbInput) {
      thumbInput.addEventListener('change', (e) => {
        const f = e.target.files?.[0];
        if (!f) return;
        const url = URL.createObjectURL(f);
        thumbPreview.src = url;
      });
    }

 // ===== 테마 토글 UI (선택 표시 + 접근성) =====
    const chipsWrap = document.getElementById('themeChips');

    // 최초 렌더: 체크박스의 checked를 보고 .active 반영
    chipsWrap?.querySelectorAll('label.chip').forEach(chip => {
      // 라벨을 포커스 가능하게
      chip.tabIndex = 0;
      const input = chip.querySelector('input[type="checkbox"]');
      if (input?.checked) chip.classList.add('active');
      chip.setAttribute('role', 'checkbox');
      chip.setAttribute('aria-checked', input?.checked ? 'true' : 'false');
    });

    // 클릭으로 토글
    chipsWrap?.addEventListener('click', (e) => {
      const chip = e.target.closest('label.chip');
      if (!chip) return;
      const input = chip.querySelector('input[type="checkbox"]');
      const willCheck = !input.checked;
      input.checked = willCheck;
      chip.classList.toggle('active', willCheck);
      chip.setAttribute('aria-checked', willCheck ? 'true' : 'false');
    });

    // ===== 일정 빌더 상태 =====
    let daySeq = 0;
    const builder = document.getElementById('builder');
    const placeInput = document.getElementById('placeInput');

    // 템플릿: Day
    function dayTemplate(idx, dateStr) {
      return `
        <div class="day" data-day="${idx}">
          <div class="day-head">
            <div class="day-title">
              <span class="pill">${idx}일차</span>
              <input type="text" class="day-name" placeholder="제목 예) Day ${idx} - 서울 출발" style="border:0; background:transparent; outline:none; font-weight:800">
            </div>
            <div class="day-controls">
              <input type="date" class="day-date" value="${dateStr || ''}" style="padding:8px 10px; border-radius:10px; border:1px solid var(--border)">
              <button type="button" class="btn btn-weak addStop">+ 장소추가</button>
              <button type="button" class="btn btn-danger removeDay">삭제</button>
            </div>
          </div>
          <div class="stops"></div>
        </div>
      `;
    }

    // 템플릿: Stop
    function stopTemplate() {
      return `
        <div class="stop">
          <div class="drag">≡</div>
          <input type="text" class="stop-name" placeholder="장소명 (예: 자갈치시장)">
          <select class="type">
            <option value="관광">관광</option>
            <option value="맛집">맛집</option>
            <option value="카페">카페</option>
            <option value="쇼핑">쇼핑</option>
          </select>
          <div class="time">
            <input type="time" class="start" value="10:00">
            <input type="time" class="end" value="12:00">
          </div>
          <button type="button" class="del">✕</button>
        </div>
      `;
    }

    // 일차 추가
    function addDay(dateStr){
      daySeq += 1;
      builder.insertAdjacentHTML('beforeend', dayTemplate(daySeq, dateStr));
    }

    document.getElementById('btnAddDay').addEventListener('click', () => addDay());

    // 카테고리 추가(예시: 유형 Select 옵션에 동적으로 추가)
    document.getElementById('btnAddCategory').addEventListener('click', () => {
      const name = prompt('추가할 카테고리명을 입력하세요');
      if(!name) return;
      builder.querySelectorAll('select.type').forEach(sel=>{
        const opt = document.createElement('option');
        opt.value = name; opt.textContent = name;
        sel.appendChild(opt);
      });
      alert('카테고리가 추가되었습니다.');
    });

    // 장소 입력창: 엔터로 현재 마지막 일차에 stop 추가
    placeInput.addEventListener('keydown', (e) => {
      if(e.key === 'Enter'){
        e.preventDefault();
        const val = placeInput.value.trim();
        if(!val) return;
        if(builder.children.length === 0) addDay();
        const lastDay = builder.lastElementChild;
        const stops = lastDay.querySelector('.stops');
        stops.insertAdjacentHTML('beforeend', stopTemplate());
        stops.lastElementChild.querySelector('.stop-name').value = val;
        placeInput.value = '';
      }
    });

    // 빌더 델리게이션
    builder.addEventListener('click', (e) => {
      if(e.target.classList.contains('addStop')){
        const dayEl = e.target.closest('.day');
        dayEl.querySelector('.stops').insertAdjacentHTML('beforeend', stopTemplate());
      }
      if(e.target.classList.contains('removeDay')){
        e.target.closest('.day').remove();
      }
      if(e.target.classList.contains('del')){
        e.target.closest('.stop').remove();
      }
    });

    // 초기 1일차 기본 추가
    addDay();

    // ===== 제출 직전 직렬화 =====
    document.addEventListener('DOMContentLoaded', () => {
	    const form = document.getElementById('courseForm');
	    form.addEventListener('submit', (e) => {
	      if(builder.children.length === 0){
	        alert('최소 1일차 이상 입력해주세요.');
	        e.preventDefault(); return;
	      }    	
      const itinerary = [];
      builder.querySelectorAll('.day').forEach((dayEl, i)=>{
        const day = {
          dayIndex: + i + 1,
          date: dayEl.querySelector('.day-date')?.value || null,
          title: dayEl.querySelector('.day-name')?.value || '',
          stops: []
        };
        dayEl.querySelectorAll('.stop').forEach((s, idx)=>{
          day.stops.push({
            order: idx+1,
            name: s.querySelector('.stop-name')?.value || '',
            type: s.querySelector('.type')?.value || '',
            startTime: s.querySelector('.start')?.value || '',
            endTime: s.querySelector('.end')?.value || ''
          });
        });
        itinerary.push(day);
      });
      document.getElementById('itineraryJson').value = JSON.stringify(itinerary);
      console.log('itinerary len =', itinerary.length, 'json bytes ~', JSON.stringify(itinerary).length);
      
      const routeNames = [];
      itinerary.forEach(d => d.stops.forEach(s => {
        if (s.name && s.name.trim()) routeNames.push(s.name.trim());
      }));
      document.getElementById('routeCsv').value = routeNames.join(',');

      const s = form.querySelector('[name="startDate"]').value;
      const eDate = form.querySelector('[name="endDate"]').value;
      if(s && eDate && new Date(s) > new Date(eDate)){
        alert('시작일이 종료일보다 늦을 수 없습니다.');
        e.preventDefault();
      }
    });

    // 초기화
    document.getElementById('btnReset').addEventListener('click', ()=>{
      if(!confirm('입력한 내용을 모두 초기화할까요?')) return;
      builder.innerHTML = '';
      daySeq = 0;
      addDay();
      form.reset();
      thumbPreview.src = '';
      document.querySelectorAll('#themeChips .chip').forEach(c=>{
        c.classList.remove('active');
        c.querySelector('input').checked = false;
      });
    });
   	});
  </script>
</body>
</html>
