<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title><c:out value="${course.title}"/> - 여행코스 자세히보기</title>

  <!-- 공통/페이지 CSS -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/header.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/trip/coursedetail.css">

  <!-- 페이지에서 꼭 필요한 보강 스타일 -->
  <style>
    .title-row{display:flex;justify-content:space-between;align-items:center;gap:12px;margin:16px 0}
    .title-row h1{margin:0;font-size:24px}
    .title-actions{display:flex;gap:8px;align-items:center}
    .title-actions button{
      background:#f8fafc;border:1px solid #d1d5db;border-radius:8px;padding:6px 12px;cursor:pointer;font-size:14px;color:#334155
    }
    .title-actions button:hover{background:#e2e8f0}
    .btn-like{border:1px solid #2563eb;color:#1d4ed8;background:#eff6ff}
    .btn-like:hover{background:#dbeafe}

    .hero{background:linear-gradient(180deg,#f3f7ff,#f1f5f9);height:320px;border-radius:16px;border:1px dashed #cbd5e1;display:flex;align-items:center;justify-content:center;color:#94a3b8;margin:14px 0 10px;overflow:hidden}
    .hero img{width:100%;height:100%;object-fit:cover;display:block;border-radius:12px}

    /* 안전하게 grid가 깨지지 않도록 보강 */
    .page{max-width:1280px;margin:24px auto 80px;padding:0 20px;display:grid;grid-template-columns:220px 1fr 320px;gap:28px}
    @media (max-width:1100px){.page{grid-template-columns:200px 1fr}.right{display:none}}
    @media (max-width:820px){.page{grid-template-columns:1fr}.sidebar{position:relative;top:auto}}
  </style>

  <meta name="viewport" content="width=device-width, initial-scale=1">
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
          <a href="${pageContext.request.contextPath}/trip/course">
            <span class="ico" aria-hidden="true">
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4.5 8-11a8 8 0 1 0-16 0c0 6.5 8 11 8 11z"/><circle cx="12" cy="11" r="3"/></svg>
            </span>
            여행코스
          </a>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/roadmap/my">
            <span class="ico" aria-hidden="true">
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 6h5a7 7 0 0 1 7 7v0a2 2 0 0 0 2 2h4"/><circle cx="6" cy="6" r="2"/><circle cx="18" cy="18" r="2"/></svg>
            </span>
            나만의 로드맵
          </a>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/recommend/user">
            <span class="ico" aria-hidden="true">
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><path d="m12 17 5 3-1.9-5.5L20 10l-5.8-.2L12 4l-2.2 5.8L4 10l4.9 4.5L7 20z"/></svg>
            </span>
            사용자 추천
          </a>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/info">
            <span class="ico" aria-hidden="true">
              <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><path d="M12 8h.01M11 12h2v4h-2z"/></svg>
            </span>
            관광지 정보
          </a>
        </li>
      </ul>
    </aside>

    <!-- 메인 -->
    <main class="main">
      <!-- 해시태그 -->
      <div class="tags">
        <c:if test="${not empty course.roadStyle}">
          <c:forEach var="t" items="${fn:split(course.roadStyle, ',')}">
            <c:set var="trimmed" value="${fn:trim(t)}"/>
            <c:if test="${not empty trimmed}">
              <span class="tag">#<c:out value="${trimmed}"/></span>
            </c:if>
          </c:forEach>
        </c:if>
      </div>

      <!-- 제목 + 액션 -->
      <div class="title-row">
        <h1><c:out value="${course.title}"/></h1>

        <div class="title-actions">
          <button type="button" class="btn-like">
            <span class="heart" aria-hidden="true">❤</span> 찜하기
          </button>

          <c:if test="${not empty sessionScope.loginMember
                       && (sessionScope.loginMember.memberNo == course.memberNo
                           || sessionScope.adminYn == 'Y')}">
            <button type="button"
                    onclick="location.href='${pageContext.request.contextPath}/trip/course/${course.id}/edit'">
              수정하기
            </button>

            <form action="${pageContext.request.contextPath}/trip/course/${course.id}/delete"
                  method="post" style="display:inline"
                  onsubmit="return confirm('정말 삭제하시겠어요? (소프트 삭제)')">
              <c:if test="${not empty _csrf}">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              </c:if>
              <button type="submit">삭제하기</button>
            </form>
          </c:if>
        </div>
      </div>

      <!-- 대표 이미지 -->
      <div class="hero">
        <c:choose>
          <c:when test="${not empty course.thumbnailUrl}">
            <img src="<c:out value='${course.thumbnailUrl}'/>"
                 alt="<c:out value='${course.title}'/>">
          </c:when>
          <c:otherwise>대표 이미지</c:otherwise>
        </c:choose>
      </div>

      <!-- 작성자/통계 (데모) -->
      <div class="author">
        <div class="who">
          <div class="avatar" aria-hidden="true"></div>
          <div>
            <div class="name">작성자</div>
            <div class="sub"><c:out value="${course.location}"/></div>
          </div>
        </div>
        <div class="stats" aria-label="콘텐츠 통계">
          <span>❤ 0</span>
          <span>💬 0</span>
          <span>👁 0</span>
        </div>
      </div>

      <!-- 코스소개 -->
      <h3 class="section-title">코스소개</h3>
      <section class="card">
        <c:choose>
          <c:when test="${not empty course.intro}">
            <c:out value="${course.intro}"/>
          </c:when>
          <c:otherwise>소개 문구가 없습니다.</c:otherwise>
        </c:choose>
      </section>

      <!-- 지도 -->
      <h3 class="section-title">지도</h3>
      <section class="card">
        <div class="map">1, 2, 3 숫자로 표시하며 순서대로 정보 표시</div>
      </section>

      <!-- 상세 일정 (컨트롤러에서 'itinerary' 모델이 설정된 경우만) -->
      <c:if test="${not empty itinerary}">
        <h3 class="section-title">상세 일정</h3>
        <div class="timeline">
          <c:choose>
            <c:when test="${not empty itinerary}">
              <c:forEach var="d" items="${itinerary}">
                <article class="tl-item">
                  <div class="tl-head">
                    <div class="tl-day">
                      Day <c:out value="${d['dayIndex']}"/>
                      <c:if test="${not empty d['title']}">
                        - <c:out value="${d['title']}"/>
                      </c:if>
                    </div>
                    <div class="tl-date"><c:out value="${d['date']}"/></div>
                  </div>

                  <div class="tl-body">
                    <!-- 경로 -->
                    <c:forEach var="s" items="${d['stops']}" varStatus="st">
                      <c:out value="${s['name']}"/><c:if test="${!st.last}"> → </c:if>
                    </c:forEach>

                    <!-- 칩 -->
                    <div class="chips">
                      <c:forEach var="s" items="${d['stops']}">
                        <c:if test="${not empty s['type']}">
                          <span class="chip"><c:out value="${s['type']}"/></span>
                        </c:if>
                      </c:forEach>
                    </div>

                    <!-- 시간 -->
                    <div class="time">
                      <c:if test="${not empty d['stops']}">
                        <c:set var="lastIdx" value="${fn:length(d['stops']) - 1}"/>
                        <c:out value="${d['stops'][0]['startTime']}"/> ~
                        <c:out value="${d['stops'][lastIdx]['endTime']}"/>
                      </c:if>
                    </div>
                  </div>
                </article>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <article class="tl-item">
                <div class="tl-head">
                  <div class="tl-day">상세 일정</div>
                  <div class="tl-date"></div>
                </div>
                <div class="tl-body">표시할 일정이 없습니다.</div>
              </article>
            </c:otherwise>
          </c:choose>
        </div>
      </c:if>
    </main>

    <!-- 우측 정보 패널 -->
    <aside class="right">
      <section class="card info-card" aria-labelledby="info-title">
        <h3 id="info-title" class="section-title" style="margin-top:0;">여행 정보</h3>

        <div class="row">
          <span class="key">총 기간</span>
          <span class="val">
            <c:choose>
              <c:when test="${not empty course.start}">
                <c:out value="${course.start}"/>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
            ~
            <c:choose>
              <c:when test="${not empty course.end}">
                <c:out value="${course.end}"/>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </span>
        </div>

        <div class="row">
          <span class="key">비용</span>
          <span class="val">
            <c:choose>
              <c:when test="${not empty course.cost}">
                <c:out value="${course.cost}"/>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </span>
        </div>

        <div class="row">
          <span class="key">여행 스타일</span>
          <span class="val">
            <c:choose>
              <c:when test="${not empty course.roadStyle}">
                <c:out value="${course.roadStyle}"/>
              </c:when>
              <c:otherwise>-</c:otherwise>
            </c:choose>
          </span>
        </div>

        <c:if test="${not empty course.slogan}">
          <div class="row">
            <span class="key">한줄 소개</span>
            <span class="val"><c:out value="${course.slogan}"/></span>
          </div>
        </c:if>
      </section>

      <section class="card">
        <h3 class="section-title" style="margin-top:0;">유의사항</h3>
        <p style="margin:0;">
          영업시간/휴무, 웨이팅은 방문 전 다시 확인해주세요. 기상 악화 시 일부 일정이 변경될 수 있습니다.
        </p>
      </section>
    </aside>
  </div>
</body>
</html>
