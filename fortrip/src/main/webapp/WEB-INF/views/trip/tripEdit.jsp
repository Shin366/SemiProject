<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8"/>
  <title>코스 수정 - <c:out value="${course.title}"/></title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css">
  <style>
  .wrap{max-width:960px;margin:24px auto;padding:0 16px}
  .card{background:#fff;border:1px solid #e5e7eb;border-radius:12px;padding:20px}
  .row{display:grid;grid-template-columns:160px 1fr;gap:12px;margin-bottom:14px;align-items:center}
  .row input,.row select,.row textarea{width:100%;padding:10px;border:1px solid #e5e7eb;border-radius:8px}
  .row textarea{min-height:140px}
  .actions{display:flex;gap:10px;justify-content:flex-end;margin-top:16px}
  .hint{color:#6b7280;font-size:12px}
  .it-box{display:grid;grid-template-columns:1fr 380px;gap:16px;margin:16px 0}
  .it-editor,.it-preview{border:1px solid #e5e7eb;border-radius:12px;background:#fff}
  .it-editor{padding:12px}
  .it-preview{padding:12px}
  .it-head{display:flex;justify-content:space-between;align-items:center;margin-bottom:8px}
  .it-head h3{margin:0;font-size:16px}
  .it-row{display:grid;grid-template-columns:1fr 1fr;gap:8px}
  .it-day{border:1px dashed #e5e7eb;border-radius:10px;padding:10px;margin:10px 0}
  .it-stops{margin-top:8px}
  .it-stop{display:grid;grid-template-columns:1.2fr .8fr .7fr .7fr 80px;gap:6px;margin:6px 0}
  .it-stop input, .it-row input, .it-stop select{padding:8px;border:1px solid #d1d5db;border-radius:8px}
  .it-btn{padding:8px 12px;border:1px solid #d1d5db;border-radius:8px;background:#f8fafc;cursor:pointer}
  .it-btn.primary{border-color:#2563eb;background:#eff6ff}
  .it-stop .it-btn{padding:6px 8px}
  .tl-item{border:1px solid #e5e7eb;border-radius:10px;padding:12px 14px 10px 14px;margin:8px 0}
  .tl-head{display:flex;justify-content:space-between;margin-bottom:4px}
  .tl-day{font-weight:800}
  .tl-date{font-size:12px;color:#6b7280}
  .chips{display:flex;gap:6px;flex-wrap:wrap;margin-top:6px}
  .chip{font-size:11px;border:1px solid #e5e7eb;border-radius:999px;padding:4px 8px;background:#f8fafc;color:#475569}
  .time{font-size:12px;color:#6b7280;margin-top:6px}
  @media(max-width:1024px){.it-box{grid-template-columns:1fr}}
  </style>
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp"/>

  <div class="wrap">
    <h1 style="margin:8px 0 16px">코스 수정</h1>

    <!-- 브라우저 기본 유효성 검사 끔: novalidate -->
    <form action="${pageContext.request.contextPath}/trip/course/${course.id}/edit" method="post" novalidate>
      <c:if test="${not empty _csrf}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
      </c:if>

      <div class="card">
        <div class="row">
          <label>제목</label>
          <input type="text" name="title" value="<c:out value='${course.title}'/>" required/>
        </div>

        <div class="row">
          <label>지역</label>
          <input type="text" name="region" value="<c:out value='${course.location}'/>"/>
        </div>

        <div class="row">
          <label>시작일</label>
          <input type="text" name="startDate" placeholder="YYYY.MM.DD 또는 YYYY-MM-DD"
                 value="<c:out value='${course.start}'/>"/>
        </div>

        <div class="row">
          <label>종료일</label>
          <input type="text" name="endDate" placeholder="YYYY.MM.DD 또는 YYYY-MM-DD"
                 value="<c:out value='${course.end}'/>"/>
        </div>

        <!-- 예산: 비워도 제출 가능하도록(브라우저 검증 방지 + 숫자만 노출) -->
        <c:set var="budgetNumber" value="${fn:replace(fn:replace(fn:replace(course.cost,'원',''),' ',''),',','')}" />
        <div class="row">
          <label>예산</label>
          <div style="display:flex;gap:8px">
            <input type="text" name="budget"
                   inputmode="numeric" pattern="[0-9]*"
                   value="<c:out value='${budgetNumber}'/>"
                   style="max-width:200px"/>
            <select name="budgetUnit" style="max-width:140px">
              <c:set var="unit" value="원"/>
              <option value="원" <c:if test="${unit == '원'}">selected</c:if>>원</option>
            </select>
          </div>
          <div class="hint">비워두면 기존 금액 유지됩니다. 숫자만 입력하세요(예: 400000).</div>
        </div>

        <div class="row">
          <label>여행 스타일</label>
          <input type="text" name="themes" placeholder="쉼표로 구분 (예: 먹방,바다,포토)"
                 value="<c:out value='${course.roadStyle}'/>"/>
          <div class="hint">저장 시 서버에서 '먹방,바다,포토' 형태로 합쳐 저장합니다.</div>
        </div>

        <div class="row">
          <label>한줄 소개</label>
          <input type="text" name="slogan" value="<c:out value='${course.slogan}'/>"/>
        </div>

        <div class="row">
          <label>코스 소개</label>
          <textarea name="description"><c:out value="${course.intro}"/></textarea>
        </div>

        <!-- 서버로 보낼 숨김 필드 (폼 안에 있어야 함) -->
        <input type="hidden" id="itineraryJson" name="itineraryJson"
               value="<c:out value='${course.itineraryJson}'/>"/>

        <div class="it-box">
          <!-- 좌: 에디터 -->
          <section class="it-editor">
            <div class="it-head">
              <h3>상세일정 편집</h3>
              <div>
                <button type="button" class="it-btn" id="btnAddDay">+ 일차 추가</button>
                <button type="button" class="it-btn primary" id="btnApply">미리보기 갱신</button>
              </div>
            </div>
            <div id="days"></div>
          </section>

          <!-- 우: 미리보기 -->
          <section class="it-preview">
            <div class="it-head">
              <h3>미리보기</h3>
              <small style="color:#6b7280">입력 즉시 반영됩니다</small>
            </div>
            <div id="preview"></div>
          </section>
        </div>

        <div class="actions">
          <button type="button" onclick="history.back()">취소</button>
          <button type="submit">저장</button>
        </div>
      </div>
    </form>
  </div>

  <script>
  document.addEventListener('DOMContentLoaded', function(){
    // ---- 상태 ----
    var data = []; // [{dayIndex, title, date, stops:[{name,type,startTime,endTime}]}]

    // ---- 엘리먼트 ----
    var daysWrap = document.getElementById('days');
    var previewWrap = document.getElementById('preview');
    var hiddenField = document.getElementById('itineraryJson');
    var btnAddDay = document.getElementById('btnAddDay');
    var btnApply = document.getElementById('btnApply');

    // ---- 유틸 ----
    function create(tag, cls, text){
      var el = document.createElement(tag);
      if(cls){ el.className = cls; }
      if(text!=null){ el.textContent = text; }
      return el;
    }
    function safe(v){ return v==null ? '' : String(v); }
    function reindex(){
      for(var i=0;i<data.length;i++){ data[i].dayIndex = i+1; }
    }

    // ---- 렌더: 에디터 ----
    function renderEditor(){
      while(daysWrap.firstChild){ daysWrap.removeChild(daysWrap.firstChild); }

      for(var i=0;i<data.length;i++){
        (function(i){
          var d = data[i];

          var dayBox = create('div','it-day');

          var row = create('div','it-row');
          var dayTitle = create('input'); dayTitle.placeholder='일차 제목 (예: 부산 남포동 투어)'; dayTitle.value = safe(d.title);
          var dayDate  = create('input'); dayDate.type='date'; dayDate.value = safe(d.date);
          row.appendChild(dayTitle); row.appendChild(dayDate);

          var headBtns = create('div', null);
          var addStopBtn = create('button','it-btn'); addStopBtn.type='button'; addStopBtn.textContent='+ 장소 추가';
          var delDayBtn  = create('button','it-btn'); delDayBtn.type='button'; delDayBtn.textContent='일차 삭제';
          headBtns.appendChild(addStopBtn);
          headBtns.appendChild(delDayBtn);

          dayBox.appendChild(row);
          dayBox.appendChild(headBtns);

          var stopsWrap = create('div','it-stops');
          for(var s=0;s<d.stops.length;s++){
            (function(s){
              var st = d.stops[s];
              var stopRow = create('div','it-stop');

              var nm = create('input'); nm.placeholder='장소명'; nm.value = safe(st.name);
              var tp = create('select');
              var types = ['','맛집','카페','관광','숙소','기타'];
              for(var t=0;t<types.length;t++){
                var opt = create('option',null,types[t]);
                opt.value = types[t];
                if(types[t]===safe(st.type)){ opt.selected=true; }
                tp.appendChild(opt);
              }
              var stt = create('input'); stt.type='time'; stt.value = safe(st.startTime);
              var edt = create('input'); edt.type='time'; edt.value = safe(st.endTime);

              var delBtn = create('button','it-btn'); delBtn.type='button'; delBtn.textContent='삭제';

              nm.addEventListener('input', function(){ st.name = nm.value; sync(); });
              tp.addEventListener('change', function(){ st.type = tp.value; sync(); });
              stt.addEventListener('change', function(){ st.startTime = stt.value; sync(); });
              edt.addEventListener('change', function(){ st.endTime = edt.value; sync(); });
              delBtn.addEventListener('click', function(){
                d.stops.splice(s,1);
                renderEditor(); sync();
              });

              stopRow.appendChild(nm);
              stopRow.appendChild(tp);
              stopRow.appendChild(stt);
              stopRow.appendChild(edt);
              stopRow.appendChild(delBtn);
              stopsWrap.appendChild(stopRow);
            })(s);
          }

          dayBox.appendChild(stopsWrap);

          dayTitle.addEventListener('input', function(){ d.title = dayTitle.value; sync(); });
          dayDate.addEventListener('change', function(){ d.date = dayDate.value; sync(); });
          addStopBtn.addEventListener('click', function(){
            d.stops.push({name:'', type:'', startTime:'', endTime:''});
            renderEditor(); sync();
          });
          delDayBtn.addEventListener('click', function(){
            data.splice(i,1);
            reindex();
            renderEditor(); sync();
          });

          daysWrap.appendChild(dayBox);
        })(i);
      }
    }

    // ---- 렌더: 미리보기 ----
    function renderPreview(){
      while(previewWrap.firstChild){ previewWrap.removeChild(previewWrap.firstChild); }
      if(!data.length){
        previewWrap.appendChild(create('div',null,'(일정 없음)'));
        return;
      }

      for(var i=0;i<data.length;i++){
        var d = data[i];
        var card = create('article','tl-item');

        var head = create('div','tl-head');
        var left = create('div','tl-day');
        var dayLabel = 'Day ' + safe(d.dayIndex);
        if(d.title){ dayLabel = dayLabel + ' - ' + d.title; }
        left.textContent = dayLabel;
        var right = create('div','tl-date'); right.textContent = safe(d.date);
        head.appendChild(left); head.appendChild(right);

        var body = create('div',null);

        var names = [];
        for(var s=0;s<d.stops.length;s++){
          if(d.stops[s] && d.stops[s].name){ names.push(d.stops[s].name); }
        }
        body.appendChild(create('div',null, names.length ? names.join(' → ') : '(장소 없음)'));

        var chips = create('div','chips');
        for(var c=0;c<d.stops.length;c++){
          var tp = d.stops[c] ? d.stops[c].type : '';
          if(tp){
            var chip = create('span','chip',tp);
            chips.appendChild(chip);
          }
        }
        body.appendChild(chips);

        var first = '', last = '';
        for(var a=0;a<d.stops.length;a++){
          if(d.stops[a] && d.stops[a].startTime){ first = d.stops[a].startTime; break; }
        }
        for(var b=d.stops.length-1;b>=0;b--){
          if(d.stops[b] && d.stops[b].endTime){ last = d.stops[b].endTime; break; }
        }
        var timeText = (first || last) ? ( (first||'') + (first&&last?' ~ ':'') + (last||'') ) : '';
        var timeDiv = create('div','time',timeText);
        body.appendChild(timeDiv);

        card.appendChild(head);
        card.appendChild(body);
        previewWrap.appendChild(card);
      }
    }

    // ---- 동기화 ----
    function sync(){
      // 항상 1부터 재번호 보정
      reindex();
      try{ hiddenField.value = JSON.stringify(data); }catch(e){}
      renderPreview();
    }

    // ---- 초기화: 버튼 이벤트 ----
    btnAddDay.addEventListener('click', function(){
      data.push({dayIndex: data.length+1, title:'', date:'', stops:[]});
      renderEditor(); sync();
    });
    btnApply.addEventListener('click', function(){ sync(); });

    // ---- 초기 로드: DB값 파싱 ----
    (function init(){
      var raw = hiddenField.value ? hiddenField.value.trim() : '';
      if(raw){
        try{
          var parsed = JSON.parse(raw);
          if(Array.isArray(parsed)){ data = parsed; }
        }catch(e){
          data = [];
        }
      }
      // 구조 보정 + 1부터 인덱싱
      for(var i=0;i<data.length;i++){
        if(!Array.isArray(data[i].stops)){ data[i].stops = []; }
      }
      reindex();
      renderEditor(); sync();
    })();
  });
  </script>
</body>
</html>
