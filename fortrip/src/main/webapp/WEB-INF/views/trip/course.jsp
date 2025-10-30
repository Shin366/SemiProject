<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>여행코스</title>
  <link rel="stylesheet" href="/resources/css/trip/course.css">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
  <!-- 공용 헤더 -->
  <jsp:include page="/WEB-INF/views/common/header.jsp"/>

  <div class="page-container">
    <!-- 사이드바 -->
    <aside class="sidebar">
      <nav>
        <ul class="sidemenu">
          <li class="active"><a href="${pageContext.request.contextPath}/trip/course">여행코스</a></li>
	        <li><a href="${pageContext.request.contextPath}/trip/course1">관리자 추천코스</a></li>
	        <li><a href="${pageContext.request.contextPath}/trip/course2">사용자 추천코스</a></li>
          <li><a href="/recommend/season">계절 추천코스</a></li>
          <li><a href="/info">관광지 정보</a></li>
        </ul>
      </nav>
    </aside>

    <!-- 메인 -->
    <main class="content">
      <!-- 검색 박스 -->
      <section class="trip-search-box">
        <h1>여행코스</h1>
        <p>FORTRIP 관리자가 추천하는 최고의 여행지를 만나보세요</p>

        <form action="/trip/search" method="get" class="search-form">
          <input type="hidden" name="size" value="8"/>

          <div class="search-row">
            <div class="field">
              <label>목적지</label>
              <div class="input-wrap">
                <input type="text" name="destination" placeholder="어디로 가시나요?" />
              </div>
            </div>

            <div class="field btn-field">
              <button type="submit">검색</button>
            </div>
          </div>

          <!-- 고급 필터 토글 (JS 없이 동작) -->
          <input type="checkbox" id="advToggle" class="visually-hidden">
          <div class="filter-link">
            <label for="advToggle" class="adv-btn">
              <span class="gear" aria-hidden="true">⚙</span> 고급 필터
              <span class="caret"></span>
            </label>
          </div>

          <!-- 펼쳐지는 고급 필터 패널 -->
          <div class="advanced-filter">
            <div class="filter-header">
              <button type="button" class="fold" onclick="document.getElementById('advToggle').click()">접기</button>
            </div>

            <!-- 카테고리 (라디오) -->
            <fieldset class="filter-group">
              <legend>카테고리</legend>
              <label class="opt"><input type="radio" name="category" value="먹방"> 먹방코스</label>
              <label class="opt"><input type="radio" name="category" value="자연"> 자연/경관</label>
              <label class="opt"><input type="radio" name="category" value="문화"> 문화유적</label>
              <label class="opt"><input type="radio" name="category" value="포토"> 포토스팟</label>
              <label class="opt"><input type="radio" name="category" value="쇼핑"> 쇼핑</label>
              <label class="opt"><input type="radio" name="category" value="바다"> 바다/섬</label>
              <label class="opt"><input type="radio" name="category" value="산"> 산</label>
              <label class="opt"><input type="radio" name="category" value="국도"> 국토대장정</label>
              <label class="opt"><input type="radio" name="category" value="축제"> 축제/행사</label>
              <label class="opt"><input type="radio" name="category" value="자전거"> 자전거</label>
            </fieldset>
          </div>
          <!-- /고급 필터 -->
        </form>
      </section>

      <!-- 카드 그리드 (4열) -->
      <section class="cards-grid">
        <c:choose>
          <c:when test="${not empty courses}">
            <c:forEach var="course" items="${courses}">
              <article class="course-card">
                <a class="card-link" href="${pageContext.request.contextPath}/trip/course/${course.id}">
                  <div class="card-thumb">
					  <c:choose>
					    <c:when test="${empty course.thumbnailUrl}">
					      <img src="${pageContext.request.contextPath}/resources/img/trip/seoul-img.png"
					           alt="<c:out value='${course.title}'/>">
					    </c:when>
					    <c:otherwise>
					      <img src="<c:out value='${course.thumbnailUrl}'/>"
					           alt="<c:out value='${course.title}'/>">
					    </c:otherwise>
					  </c:choose>
				  </div>
                  <div class="card-body">
                    <h3 class="card-title"><c:out value="${course.title}"/></h3>

                    <!-- 칩: 배경/타원 제거 → 텍스트만 -->
                    <div class="card-route" title="${course.route}">
                      <c:forEach var="spot" items="${course.routeList}" varStatus="st">
                        <span class="chip text-only"><c:out value="${spot}"/></span>
                        <c:if test="${!st.last}"><span class="arrow">→</span></c:if>
                      </c:forEach>
                    </div>

                    <ul class="card-meta">
                      <li><img src="/resources/img/trip/distance.png" alt=""><span></span></li>
                      <li><img src="/resources/img/trip/schedule.png" alt=""><span></span></li>
                      <li><img src="/resources/img/trip/star.png" alt=""><span></span></li>
                      <li><img src="/resources/img/trip/card.png" alt=""><span>￦</span></li>
                    </ul>

                    <div class="card-foot">
                      <span class="card-date">
                        <fmt:formatDate value='${course.createdAt}' pattern='yyyy.MM.dd'/> 등록
                      </span>
                    </div>
                  </div>
                </a>
              </article>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <div class="empty">표시할 여행코스가 없습니다.</div>
          </c:otherwise>
        </c:choose>
      </section>

      <!-- 페이징 -->
      <c:set var="page" value="${empty param.page ? (empty page ? 1 : page) : param.page}"/>
      <c:set var="size" value="${empty param.size ? 8 : param.size}"/> 
      <c:set var="totalPages" value="${empty totalPages ? 1 : totalPages}"/>

      <nav class="pagination" aria-label="페이지네이션">
        <c:set var="prevPage" value="${page - 1}"/>
        <c:set var="nextPage" value="${page + 1}"/>

        <a class="page-btn prev ${page <= 1 ? 'disabled' : ''}"
           href="${pageContext.request.contextPath}/trip/course?page=${prevPage}&size=${size}"
           aria-disabled="${page <= 1}">이전</a>

        <ul class="page-list">
          <c:forEach var="p" begin="1" end="${totalPages}">
            <li>
              <a class="page-num ${p == page ? 'active' : ''}"
                 href="${pageContext.request.contextPath}/trip/course?page=${p}&size=${size}">
                ${p}
              </a>
            </li>
          </c:forEach>
        </ul>

        <a class="page-btn next ${page >= totalPages ? 'disabled' : ''}"
           href="${pageContext.request.contextPath}/trip/course?page=${nextPage}&size=${size}"
           aria-disabled="${page >= totalPages}">다음</a>
      </nav>

      <!-- 사용자 추천 섹션 -->   
      <section class="user-recommend">
        <h2>당신만을 위한 사용자 추천 특별한 여행</h2>
        <p>모든 경험이 담긴 특별한 여행을 지금 바로 만나보세요!</p>
        <a class="cta" href="${pageContext.request.contextPath}/trip/course">지금부터 찾아보기</a>
      </section>
      <button class="new-btn" onclick="location.href='/trip/add'">새 로드맵 만들기</button>
    </main>
  </div>
</body>
</html>
