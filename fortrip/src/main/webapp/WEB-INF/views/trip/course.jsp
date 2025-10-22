<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>여행코스</title>
  <link rel="stylesheet" href="/resources/css/common/header.css">
  <link rel="stylesheet" href="/resources/css/trip/course.css">
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp"/>

  <div class="page-container">
    <!-- 사이드바 -->
    <aside class="sidebar">
      <ul>
        <li class="active"><a href="/trip/course">여행코스</a></li>
        <li><a href="/roadmap/my">나만의 로드맵</a></li>
        <li><a href="/recommend/user">사용자 추천</a></li>
        <li><a href="/info">관광지 정보</a></li>
      </ul>
    </aside>

    <!-- 메인 -->
    <main class="content">
      <!-- 검색 박스 -->
      <section class="trip-search-box">
        <h1>여행코스</h1>
        <p>FORTRIP 관리자가 추천하는 최고의 여행지를 만나보세요</p>

        <form action="${pageContext.request.contextPath}/trip/search" method="get" class="search-form">
          <input type="hidden" name="size" value="8"/>
          <div class="search-row">
            <div class="field">
              <label>목적지</label>
              <div class="input-wrap">
                <input type="text" name="destination" value="${param.destination}" placeholder="어디로 가시나요?" />
              </div>
            </div>

            <div class="field">
              <label>체크인</label>
              <div class="input-wrap">
                <input type="date" name="checkin" value="${param.checkin}" />
              </div>
            </div>

            <div class="field">
              <label>체크아웃</label>
              <div class="input-wrap">
                <input type="date" name="checkout" value="${param.checkout}" />
              </div>
            </div>

            <div class="field">
              <label>인원</label>
              <div class="input-wrap">
                <input type="text" name="people" value="${param.people}" placeholder="1명" />
              </div>
            </div>

            <div class="field btn-field">
              <button type="submit">검색</button>
            </div>
          </div>

          <div class="filter-link">
            <a href="#">⚙ 고급 필터</a>
          </div>
        </form>
      </section>

      <!-- 리스트 타이틀 -->
      <header class="list-header">
        <div>
          <h2>추천 여행코스</h2>
          <p class="subtitle">전문가와 여행자들이 추천하는 최고의 여행코스를 만나보세요</p>
        </div>
        <div class="count">
          총 <strong><c:out value="${totalCount != null ? totalCount : (courses != null ? fn:length(courses) : 0)}"/></strong>개
        </div>
      </header>

      <!-- 카드 그리드 (4열) -->
      <section class="cards-grid">
        <c:choose>
          <c:when test="${not empty courses}">
            <c:forEach var="course" items="${courses}">
              <article class="course-card">
                <a class="card-link" href="${pageContext.request.contextPath}/trip/course/${course.id}">
                  <div class="card-thumb">
                    <img src="<c:out value='${empty course.thumbnailUrl ? pageContext.request.contextPath += "/resources/img/trip/seoul-img.png" : course.thumbnailUrl}'/>"
                         alt="<c:out value='${course.title}'/>">
                  </div>
                  <div class="card-body">
                    <h3 class="card-title"><c:out value="${course.title}"/></h3>

                    <div class="card-route" title="${course.route}">
                      <!-- route는 '경복궁, 북촌한옥마을, 인사동, 명동' 같은 CSV라고 가정 -->
                      <c:forEach var="spot" items="${course.routeList}" varStatus="st">
                        <span class="chip"><c:out value="${spot}"/></span>
                        <c:if test="${!st.last}"><span class="arrow">→</span></c:if>
                      </c:forEach>
                    </div>

                    <ul class="card-meta">
                      <li><img src="${pageContext.request.contextPath}/resources/img/trip/distance.png" alt=""><span><c:out value="${course.city}"/></span></li>
                      <li><img src="${pageContext.request.contextPath}/resources/img/trip/schedule.png" alt=""><span><c:out value="${course.duration}"/></span></li>
                      <li><img src="${pageContext.request.contextPath}/resources/img/trip/star.png" alt=""><span><fmt:formatNumber value='${course.rating}' minFractionDigits='1' maxFractionDigits='1'/></span></li>
                      <li><img src="${pageContext.request.contextPath}/resources/img/trip/card.png" alt=""><span><fmt:formatNumber value='${course.price}' type='number'/>￦</span></li>
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

      <!-- 페이징 : 4×2 = 8개씩 -->
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
        <a class="cta" href="${pageContext.request.contextPath}/recommend/user">지금부터 찾아보기</a>
      </section>
    </main>
  </div>
</body>
</html>
