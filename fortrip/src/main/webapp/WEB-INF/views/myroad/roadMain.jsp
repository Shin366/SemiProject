<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>나만의 로드맵 - ForTrip</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myroad/roadmain.css">
</head>

<body>
  <jsp:include page="/WEB-INF/views/common/header.jsp"/>

  <div class="page-container">
    <!-- 왼쪽 메뉴 -->
    <aside class="sidebar">
      <ul>
        <li><a href="/trip/course">여행코스</a></li>
        <li class="active"><a href="/trip/roadmap/my">나만의 로드맵</a></li>
        <li><a href="/trip/info">관광지 정보</a></li>
      </ul>
    </aside>

    <!-- 메인 -->
    <main class="content">
      <h1>나만의 로드맵</h1>

      <div class="roadmap-list">
        <c:choose>
          <c:when test="${not empty courseList}">
            <c:forEach var="c" items="${courseList}">
              <div class="roadmap-card">
                <div class="thumbnail">
                  <c:choose>
                    <c:when test="${not empty c.thumbUrl}">
                      <img src="${c.thumbUrl}" alt="${c.roadName}" style="width:100%;height:150px;object-fit:cover;border-radius:8px;">
                    </c:when>
                    <c:otherwise>
                      <div style="width:100%;height:150px;background:#e2e8f0;border-radius:8px;display:flex;align-items:center;justify-content:center;color:#64748b;">
                        썸네일 없음
                      </div>
                    </c:otherwise>
                  </c:choose>
                </div>

                <div class="info">
                  <span class="badge">로드맵</span>
                  <div class="title">
                    <a href="/trip/course/${c.roadNo}">${c.roadName}</a>
                  </div>
                  <div class="meta">
                    <span>${c.writeDate}</span>
                    <span>💰 ${c.roadCost}</span>
                    <span>#${c.roadStyle}</span>
                  </div>
                </div>

                <div class="actions">
                  <%-- 본인 작성글만 수정/삭제 가능 --%>
                  <c:if test="${sessionScope.loginMember != null && sessionScope.loginMember.memberNo == c.memberNo}">
                    <a href="/trip/course/${c.roadNo}/edit" class="btn-edit">수정하기</a>
                    <form action="/trip/course/${c.roadNo}/delete" method="post" style="display:inline;" 
                          onsubmit="return confirm('정말 삭제하시겠어요? (삭제 시 복구 불가)');">
                      <button type="submit" class="btn-delete">삭제하기</button>
                    </form>
                  </c:if>
                </div>
              </div>
            </c:forEach>
          </c:when>

          <c:otherwise>
            <p style="text-align:center;color:#94a3b8;margin-top:40px;">
              등록된 나만의 로드맵이 없습니다.<br>
              아래 버튼을 눌러 새 로드맵을 만들어보세요!
            </p>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- ✅ 동적 페이지네이션 -->
      <c:if test="${totalPages > 1}">
        <div class="pagination">
          <c:forEach var="i" begin="1" end="${totalPages}">
            <button 
              onclick="location.href='?page=${i}'" 
              style="${i == page ? 'background:#0066ff;color:#fff;' : ''}">
              ${i}
            </button>
          </c:forEach>
        </div>
      </c:if>

      <button class="new-btn" onclick="location.href='/trip/add'">새 로드맵 만들기</button>
    </main>
  </div>
</body>
</html>
