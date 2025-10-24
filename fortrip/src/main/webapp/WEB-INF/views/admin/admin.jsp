<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fortrip - 관리자 대시보드</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
<link rel="stylesheet" href="../../../resources/css/admin/main.css">
</head>
<body>
   <div id="container">
      <jsp:include page="/WEB-INF/views/admin/include/header.jsp"/>
      <section id="section">
            <aside id="section-aside">
                <div class="side-menu">

                    <!-- ************************** 대시보드 ******************************* -->
                    <div class="menu-title">대시보드</div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined" style="color: #fff;">finance</span>
                            <span style="color: #fff;">통계 개요</span>
                        </div>
                    </div>
                    <!-- ************************** 대시보드 끝 ******************************* -->

                    <!-- ************************** 회원 관리 ******************************* -->
                    <div class="menu-title">회원 관리</div>

                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">groups</span>
                            <span>전체 회원 목록</span>
                        </div>
                    </div>

                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">person_edit</span>
                            <span>회원 정보 수정</span>
                        </div>
                    </div>

                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">person_cancel</span>
                            <span>활동 정지 관리</span>
                        </div>
                    </div>
                    <!-- ************************** 회원 관리 끝 ******************************* -->

                    <!-- ************************** 컨텐츠 관리 ******************************* -->
                    <div class="menu-title">콘텐츠 관리</div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">route</span>
                            <span>여행 코스 관리</span>
                        </div>
                    </div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">tour</span>
                            <span>관광 정보 관리</span>
                        </div>
                    </div>
                    <!-- ************************** 컨텐츠 관리 끝 ******************************* -->

                    <!-- ************************** 게시판 관리 ******************************* -->
                    <div class="menu-title">게시판 관리</div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">brand_awareness</span>
                            <span>공지사항 관리</span>
                        </div>
                    </div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">help_center</span>
                            <span>문의글 관리</span>
                        </div>
                    </div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">comment</span>
                            <span>게시물 관리</span>
                        </div>
                    </div>
                    <!-- ************************** 게시판 관리 끝 ******************************* -->
                </div>

                <div class="side-setting">
                    <div class="menu-item">
                        <div class="menu-list" style="margin-top: 5px;">
                            <span class="material-symbols-outlined">manage_accounts</span>
                            <span>계정 설정</span>
                        </div>
                    </div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined" style="color: red;">logout</span>
                            <span style="color: red;">로그아웃</span>
                        </div>
                    </div>
                </div>
            </aside>

            <section id="section-main">
                <section id="dashboard">
                    <h2>통계 개요</h2>
                    <p>사이트 관리 통계, 인기 키워드, 회원 가입 현황 통계</p>

                    <div class="dashboard-statistics">
                    
                        <div class="top-row">
                            <div class="allUser">
                                <span class="material-symbols-outlined" style="background-color: #98e6fb; color: #0796E5;">groups</span>
                                <span class="num">${getMemberCount}</span>
                                <span class="label">전체 회원수</span>
                            </div>
                            <div class="travelCourse">
                                <span class="material-symbols-outlined" style="background-color: #a5eea5; color: green;">route</span>
                                <span class="num">320</span>
                                <span class="label">전체 여행 코스수</span>
                            </div>
                            <div class="reviewCount">
                                <span class="material-symbols-outlined" style="background-color:#cbc3e3; color: purple;">reviews</span>
                                <span class="num">210</span>
                                <span class="label">전체 후기 수</span>
                            </div>
                            <div class="reviewCount">
                                <span class="material-symbols-outlined" style="background-color:#f0c499; color: #ff7f00;">star</span>
                                <span class="num">4.8</span>
                                <span class="label">평균 만족도</span>
                            </div>
                        </div>

                        <div class="bottom-row">
                            <div class="hotkeyword">
                                <h4>인기 여행지 키워드</h4>
                                <canvas id="keywordChart"></canvas>
                            </div>
                            <div class="userSignup">
                                <h4>회원 가입 현황</h4>
                                <canvas id="userChart"></canvas>
                            </div>
                        </div>
                    </div>
                </section>
                <hr style="border: 1px solid #ccc;">

                <section id="user">
                    <h2>회원 관리</h2>
                    <p>전체 회원및 회원 관리</p>

                    <div class="dashboard-userInfo">
                    
                        <div class="top-row">
                            <div class="allUser">
                                <span class="material-symbols-outlined">groups</span>
                                <span class="num">${getMemberCount}</span>
                                <span class="label">전체 회원수</span>
                            </div>
                            <div class="travelCourse">
                                <span class="material-symbols-outlined">person_check</span>
                                <span class="num">${getMemberActiveCount}</span>
                                <span class="label">활성 회원수</span>
                            </div>
                            <div class="reviewCount">
                                <span class="material-symbols-outlined">person_cancel</span>
                                <span class="num">${getMemberStopCount}</span>
                                <span class="label">활동 정지</span>
                            </div>
                        </div>
                        
                        <form id="userSearchForm">
                            <div class="search-container"> 
                                <span class="material-symbols-outlined">search</span>
                                <input type="text" placeholder="회원 이름 또는 아이디 검색">
                            </div>
                            <select name="" id="">
                                <option value="" selected>활동 상태</option>
                                <option value="">비활성</option>
                                <option value="">활성</option>
                            </select>
                        </form>
                        <div class="userAdd">
                            <button id="userAdd-btn" onclick="location.href='/user/insert'">+ 회원 추가</button>
                        </div>
                        <div class="userInfo-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>회원 정보</th>
                                        <th>등급</th>
                                        <th>성별</th>
                                        <th>가입일</th>
                                        <th>전화번호</th>
                                        <th>상태</th>
                                        <th>작업</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                   <c:forEach var="mList" items="${mList }">
                                   <input type="hidden"  name="memberNo" value="${mList.memberNo }"/>
                                       <tr>
                                           <td>
                                               <div class="profile-cell">
	                                               <div class="profile-info">
	                                                   <span class="name">${mList.memberName}</span>
	                                                   <span class="email">${mList.email }</span>
	                                               </div>
                                               </div>
                                           </td>
                                           <c:choose>
                                              <c:when test="${mList.adminYn == 'Y'}" >
                                                 <td><span class="status admin">관리자</span></td>
                                              </c:when>
                                              <c:otherwise>
                                                 <td><span class="status user">일반 회원</span></td>
                                              </c:otherwise>
                                           </c:choose>
                                           <td>${mList.gender}</td>
                                           <td>${mList.enrollDate }</td>
                                           <td>${mList.phone }</td>
                                           <c:choose>
                                          <c:when test="${mList.statusYsn == 'Y'}">
                                             <td><span class="status active">활성</span></td>
                                          </c:when>
                                          <c:when test="${mList.statusYsn == 'N' }">
                                             <td><span class="status inactive">비활성</span></td>
                                          </c:when>
                                          <c:otherwise>
                                             <td><span class="status stop">정지</span></td>
                                          </c:otherwise>
                                       </c:choose> 
                                           <td>
	                                           <form action="/admin/user/modify">
	                                           	   <input type="hidden"  name="memberNo" value="${mList.memberNo }"/>
		                                           <button type="submit" class="action-link">수정</button>
		                                           <button type="submit" class="action-link danger">정지</button>
	                                           </form>
                                           </td>
                                       </tr>
                                    </c:forEach>   
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="7">
                                            <nav class="pagination">
                                                <c:if test="${startNavi ne 1 }">
                                             <a href="/admin/main?page=${startNavi - 1}" class="prev">&laquo; 이전</a>
                                          </c:if>
                                        <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                                             <a href="/admin/main?page=${n }" class='page-number <c:if test="${currentPage eq n }">active</c:if>'>${n }</a>
                                         </c:forEach>
                                         <c:if test="${endNavi ne maxPage }">
                                             <a href="/admin/main?page=${endNavi + 1}" class="next">다음 &raquo;</a>
                                          </c:if>
                                            </nav>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                    </div>
                </section>
                <hr style="border: 1px solid #ccc;">

                <section id="content">
                    <h2>콘텐츠 관리</h2>
                    <p>여행 코스 및 관광 정보 관리</p>

                    <div class="dashboard-content">
                        <!--********************여행 코스 관리******************-->
                        <div class="travelCourse-setting">
                            <div class="setting-title">여행 코스 관리</div>
                            <form action="" id="course-searchForm">
                                <div class="search-course">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="코스명, 지역으로 검색..">
                                    <button id="courseAdd-btn">+ 새 코스</button>
                                </div>
                            </form>
                            <div class="course-content">
                                <div class="course-card">
                                    <div class="card-img"></div>
                                    <span class="course-title">서울 도심문화 코스</span>
                                    <div class="card-info">
                                        <div class="card-header">
                                            <span>경북궁</span>→
                                            <span>경북궁</span>→
                                            <span>경북궁</span>→
                                            <span>경북궁</span>
                                        </div>
                                        <div class="card-main">
                                            <div class="card-item">
                                                <span class="material-symbols-outlined">location_on</span>
                                                <span>서울</span>
                                            </div>
                                            <div class="card-item">
                                                <span class="material-symbols-outlined">schedule</span>
                                                <span>서울</span>
                                            </div>
                                            <div class="card-item">
                                                <span class="material-symbols-outlined">star</span>
                                                <span>서울</span>
                                            </div>
                                            <div class="card-item">
                                                <span class="material-symbols-outlined">credit_card</span>
                                                <span>50,000￦</span>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <span class="card-date">2025.10.25 등록</span>
                                            <div class="card-btn-row">
                                                <a href="#" id="course-modify-btn">수정</a>
                                                <a href="#" id="course-delete-btn">삭제</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--********************여행 코스 관리 끝******************-->

                        <!--********************관광지 관리******************-->
                        <div class="travelInfoSetting">
                            <div class="travel-setting-title">관광지 관리</div>
                            <form action="" id="travel-searchForm">
                                <div class="travel-search-course">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="코스명, 지역으로 검색..">
                                    <button id="travel-Add-btn">+ 새 관광지</button>
                                </div>
                            </form>
                            <div class="travel-content">
                                <!--********************카드 시작******************-->
                                <div class="travel-card">
                                    <div class="travel-card-img"></div>
                                    <span class="travel-title">서울 도심문화 코스</span>
                                    <div class="travel-card-info">
                                        <div class="travel-card-header">
                                            <span>경북궁</span>→
                                            <span>경북궁</span>→
                                            <span>경북궁</span>→
                                            <span>경북궁</span>
                                        </div>
                                        <div class="travel-card-main">
                                            <div class="travel-card-item">
                                                <span class="material-symbols-outlined">location_on</span>
                                                <span>서울</span>
                                            </div>
                                            <div class="travel-card-item">
                                                <span class="material-symbols-outlined">schedule</span>
                                                <span>서울</span>
                                            </div>
                                            <div class="travel-card-item">
                                                <span class="material-symbols-outlined">star</span>
                                                <span>서울</span>
                                            </div>
                                            <div class="travel-card-item">
                                                <span class="material-symbols-outlined">credit_card</span>
                                                <span>50,000￦</span>
                                            </div>
                                        </div>
                                        <div class="travel-card-footer">
                                            <span class="travel-card-date">2025.10.25 등록</span>
                                            <div class="travel-card-btn-row">
                                                <a href="#" id="travel-modify-btn">수정</a>
                                                <a href="#" id="travel-delete-btn">삭제</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--********************카드 끝******************-->
                            </div>
                        </div>
                        <!--********************관광지 관리 끝******************-->
                    </div>
                </section>
                <hr style="border: 1px solid #ccc;">

                <section id="board">
                    <h2>게시판 관리</h2>
                    <p>공지사항 및 문의글 관리</p>

                    <div class="dashboard-borad">
                        <div class="board-chart">
                            <div class="allBoard">
                                <span class="material-symbols-outlined" style="background-color: #98e6fb; color: #0796E5;">groups</span>
                                <span class="num">2000</span>
                                <span class="label">총 게시물 갯수</span>
                            </div>
                            <div class="allNotice">
                                <span class="material-symbols-outlined" style="background-color: #a5eea5; color: green;">route</span>
                                <span class="num">320</span>
                                <span class="label">공지사항</span>
                            </div>
                            <div class="allDeclarationBoard">
                                <span class="material-symbols-outlined" style="background-color:#cbc3e3; color: purple;">reviews</span>
                                <span class="num">210</span>
                                <span class="label">신고 게시물</span>
                            </div>
                            <div class="allInquiryBoard">
                                <span class="material-symbols-outlined" style="background-color:#f0c499; color: #ff7f00;">star</span>
                                <span class="num">4.8</span>
                                <span class="label">문의글</span>
                            </div>
                        </div>

                        <!--***********************게시물 관리*******************************-->
                        <div class="board-wrapper">
                            <div class="board-title">게시물 관리</div>
                            <form action="" id="board-search-form">
                                <div class="board-search-wrapper">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="제목, 내용으로 검색..">
                                </div>
                            </form>

                            <div class="board-content">
                                <div class="board-list" style="background-color: #D4DBFF">
                                    <div class="board-list-header">
                                    <div class="board-category">
                                        <p style="background-color: #5D78FF;">일반</p>
                                    </div>
                                    <div class="board-date">2025.10.25&nbsp;&nbsp;09:15</div>
                                    <div class="board-btn">
                                        <button class="delete-btn">삭제</button>
                                    </div>
                                    </div>

                                    <div class="board-list-title">
                                    <span>제주도 여행 코스 추천해주세요</span>
                                    </div>

                                    <div class="board-list-detail">
                                    제목 그대로 가봤던곳에서 좋았던 곳 추천해주세요!
                                    </div>

                                    <div class="board-list-footer">
                                    <div class="board-list-view">
                                        <span class="material-symbols-outlined">visibility</span>
                                        <span>205 조회</span>
                                    </div>
                                    <div class="board-list-comment">
                                        <span class="material-symbols-outlined">chat_bubble</span>
                                        <span>150 댓글</span>
                                    </div>
                                    </div>
                                </div>
                            </div> 
                            <div class="board-content">
                                <div class="board-list" style="background-color: #D4DBFF">
                                    <div class="board-list-header">
                                    <div class="board-category">
                                        <p style="background-color: #5D78FF;">일반</p>
                                    </div>
                                    <div class="board-date">2025.10.25&nbsp;&nbsp;09:15</div>
                                    <div class="board-btn">
                                        <button class="delete-btn">삭제</button>
                                    </div>
                                    </div>

                                    <div class="board-list-title">
                                    <span>제주도 여행 코스 추천해주세요</span>
                                    </div>

                                    <div class="board-list-detail">
                                    제목 그대로 가봤던곳에서 좋았던 곳 추천해주세요!
                                    </div>

                                    <div class="board-list-footer">
                                    <div class="board-list-view">
                                        <span class="material-symbols-outlined">visibility</span>
                                        <span>205 조회</span>
                                    </div>
                                    <div class="board-list-comment">
                                        <span class="material-symbols-outlined">chat_bubble</span>
                                        <span>150 댓글</span>
                                    </div>
                                    </div>
                                </div>
                            </div> 

                            <div class="board-pagination-wrapper">
                                <nav class="board-pagination">
                                    <c:if test="${startNavi ne 1 }">
                                        <a href="/?page=${startNavi - 1}" class="prev">&laquo; 이전</a>
                                    </c:if>
                                    <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                                        <a href="/?page=${n }" class='page-number <c:if test="${currentPage eq n }">active</c:if>'>${n }</a>
                                    </c:forEach>
                                    <c:if test="${endNavi ne maxPage }">
                                        <a href="/?page=${endNavi + 1}" class="next">다음 &raquo;</a>
                                    </c:if>
                                </nav>
                            </div>
                        </div>
                        <!--***********************게시물 관리 끝*******************************-->

                        <!--***********************공지사항 관리*******************************-->
                        <div class="board-wrapper">
                            <div class="board-title">공지사항 관리</div>
                            <form action="" id="board-search-form">
                                <div class="board-search-wrapper">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="제목, 내용으로 검색..">
                                    <button id="notice-Add-btn" style="background-color: #ff7a00;">+ 새 공지사항</button>
                                </div>
                            </form>

                            <!-- 공지사항 리스트 -->
                            <div class="notice-content"></div>
                                 
                            <div class="board-pagination-wrapper">
                                <nav class="board-pagination">
                                    <c:if test="${startNavi ne 1 }">
                                        <a href="/?page=${startNavi - 1}" class="prev">&laquo; 이전</a>
                                    </c:if>
                                    <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                                        <a href="/?page=${n }" class='page-number <c:if test="${currentPage eq n }">active</c:if>'>${n }</a>
                                    </c:forEach>
                                    <c:if test="${endNavi ne maxPage }">
                                        <a href="/?page=${endNavi + 1}" class="next">다음 &raquo;</a>
                                    </c:if>
                                </nav>
                            </div>
                        </div>
                        <!--***********************공지사항 관리 끝*******************************-->

                        <!--***********************신고 게시물 관리*******************************-->
                        <div class="board-wrapper">
                            <div class="board-title">신고 게시물 관리</div>
                            <form action="" id="board-search-form">
                                <div class="board-search-wrapper">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="제목, 내용으로 검색..">
                                </div>
                            </form>

                            <div class="board-content">
                                <div class="board-list" style="background-color: #FFD0D0;">
                                    <div class="board-list-header">
                                    <div class="board-category">
                                        <p style="background-color: #DC2626;">신고 게시판</p>
                                    </div>
                                    <div class="board-date">2025.10.15&nbsp;&nbsp;09:15</div>
                                    </div>

                                    <div class="board-list-title">
                                    <span>여행 코스 추가 안내</span>
                                    </div>

                                    <div class="board-list-detail">
                                    서울시 종로구 여행 코스를 추가하였습니다. 많은 관심 바랍니다.
                                    </div>
                                </div>
                            </div>
                            <div class="board-content">
                                <div class="board-list" style="background-color: #FFD0D0;">
                                    <div class="board-list-header">
                                    <div class="board-category">
                                        <p style="background-color: #DC2626;">신고 게시판</p>
                                    </div>
                                    <div class="board-date">2025.10.15&nbsp;&nbsp;09:15</div>
                                    </div>

                                    <div class="board-list-title">
                                    <span>여행 코스 추가 안내</span>
                                    </div>

                                    <div class="board-list-detail">
                                    서울시 종로구 여행 코스를 추가하였습니다. 많은 관심 바랍니다.
                                    </div>
                                </div>
                            </div>
                                 
                            <div class="board-pagination-wrapper">
                                <nav class="board-pagination">
                                    <c:if test="${startNavi ne 1 }">
                                        <a href="/?page=${startNavi - 1}" class="prev">&laquo; 이전</a>
                                    </c:if>
                                    <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                                        <a href="/?page=${n }" class='page-number <c:if test="${currentPage eq n }">active</c:if>'>${n }</a>
                                    </c:forEach>
                                    <c:if test="${endNavi ne maxPage }">
                                        <a href="/?page=${endNavi + 1}" class="next">다음 &raquo;</a>
                                    </c:if>
                                </nav>
                            </div>
                        </div>
                        <!--***********************신고 게시물 관리 끝*******************************-->

                        <!--***********************문의글 관리*******************************-->
                        <div class="board-wrapper">
                            <div class="board-title">문의글 관리</div>
                            <form action="" id="board-search-form">
                                <div class="board-search-wrapper">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="제목, 내용으로 검색..">
                                </div>
                            </form>


                            <!-- 문의글 리스트 fetch API -->
                            <div class="qnaBoard-content"></div>

                        
                            </div>
                            
                            <div class="board-pagination-wrapper">
                                <nav class="board-pagination">
                                    <c:if test="${startNavi ne 1 }">
                                        <a href="/?page=${startNavi - 1}" class="prev">&laquo; 이전</a>
                                    </c:if>
                                    <c:forEach begin="${startNavi }" end="${endNavi }" var="n">
                                        <a href="/?page=${n }" class='page-number <c:if test="${currentPage eq n }">active</c:if>'>${n }</a>
                                    </c:forEach>
                                    <c:if test="${endNavi ne maxPage }">
                                        <a href="/?page=${endNavi + 1}" class="next">다음 &raquo;</a>
                                    </c:if>
                                </nav>
                            </div>
                        </div>
                        <!--***********************문의글 관리 끝*******************************-->

                        <!--***********************자주하는 질문*******************************-->
                        <div class="board-wrapper">
                            <div class="board-title">공지사항 관리</div>
                            <form action="" id="board-search-form">
                                <div class="board-search-wrapper">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="제목, 내용으로 검색..">
                                    <button id="notice-Add-btn">+ 새 질문</button>
                                </div>
                            </form>

                            <div class="question-content">
                                <div class="question-category">
                                    <ul>
                                        <li>
                                            <input type="radio" value="여행관련" id="travel-checkbox">
                                            <label for="travel-checkbox">여행 관련</label>
                                        </li>
                                        <li>
                                            <input type="radio" value="회원관련" id="user-checkbox">
                                            <label for="user-checkbox">회원 관련</label>
                                        </li>
                                        <li>
                                            <input type="radio" value="커뮤니티" id="community-checkbox">
                                            <label for="community-checkbox">커뮤니티 & 고객센터</label>
                                        </li>
                                        <li>
                                            <input type="radio" value="찜하기" id="review-checkbox">
                                            <label for="review-checkbox">찜하기 및 리뷰</label>
                                        </li>
                                    </ul>
                                </div>
                                
                                <!-- 자주하는 질문 리스트  -->
                                <div class="qna-list"></div>
                            </div>
                        </div>
                        <!--***********************자주하는 질문 관리 끝*******************************-->
                    </div>
                </section>
            </section>
        </section>
   </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
    <script src="../../../resources/css/admin/js/chart.js"></script>
    <script src="../../../resources/css/admin/js/List-move.js"></script>
    <script>
        function questionFun() {
            fetch("/admin/question/list")
                .then(response => response.json())
                .then(qList => {
                    const questionList = document.querySelector(".qna-list");
                    questionList.innerHTML = '';
                    qList.forEach(question => {                    
                    	questionList.innerHTML += `
                            <div class="question-list">
                                <div class="question-list-header">
                                    <div class="question-title">
                                        <h4><span>Q.</span>\${question.questionTitle}</h4>
                                    </div>
                                    <div class="question-btn">
                                        <a href="/admin/question/modify?question=\${question.questionNo}" class="edit-btn">수정</a>
                                        <form action="/admin/question/delete" method="post" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                                            <input type="hidden" name="questionNo" value="\${question.questionNo}">
                                            <button type="submit" class="delete-btn">삭제</button>
                                        </form>
                                    </div>
                                </div>
                                <div class="question-list-content">
                                    <p><span>A. </span>\${question.questionContent}</p>
                                </div>
                            </div> `;
                    });
                })
                .catch(error => console.log(error))
        }
        questionFun();

        function noticeFun() {
            fetch("/admin/notice/list")
            .then(response => response.json())
            .then(nList => {
                console.log(nList);
                const noticeList = document.querySelector(".notice-content");
                noticeList.innerHTML='';
                nList.forEach(notice => {
                    noticeList.innerHTML+=`
                        <div class="board-list" style="background-color: #fff5ef">
                            <div class="board-list-header">
                            <div class="board-category">
                                <p style="background-color: #ff7a00;">공지사항</p>
                            </div>
                            <div class="board-date">\${notice.writeDate}</div>
                            <div class="board-btn">
                                <button class="edit-btn">수정</button>
                                <button class="delete-btn">삭제</button>
                            </div>
                            </div>

                            <div class="board-list-title">
                            <span>\${notice.noticeTitle}</span>
                            </div>

                            <div class="board-list-detail">
                            \${notice.noticeContent}
                            </div>

                            <div class="board-list-footer">
                            <div class="board-list-view">
                                <span class="material-symbols-outlined">visibility</span>
                                <span>\${notice.viewCount} 조회</span>
                            </div>
                            <div class="board-list-comment">
                                <span class="material-symbols-outlined">chat_bubble</span>
                                <span>\${notice.viewCount} 댓글</span>
                            </div>
                            </div>
                        </div>
                    `
                })
            })
            .catch(error => console.log(error))
        }
        noticeFun();
        
        function qnaFun() {
            fetch("/admin/qna/list")
            .then(response => response.json())
            .then(qnaList => {
                const qnaBoardList = document.querySelector(".qnaBoard-content");
                qnaBoardList.innerHTML = '';
                qnaList.forEach(qList => {
                    qnaBoardList.innerHTML+=`
                        <div class="board-list" style="background-color: #D9FFD9;">
                            <div class="board-list-header">
                            <div class="board-category">
                                <p style="background-color: #059905;">문의글</p>
                            </div>
                            <div class="board-date">\${qList.writeDate}</div>
                            <div class="board-btn">
                                <button class="delete-btn">삭제</button>
                            </div>
                            </div>

                            <div class="board-list-title">
                            <span>\${qList.qnaTitle}</span>
                            </div>

                            <div class="board-list-detail">
                            \${qList.qnaContent}
                            </div>

                            <div class="board-list-footer">
                            <div class="board-list-view">
                                <span class="material-symbols-outlined">visibility</span>
                                <span>\${qList.viewCount} 조회</span>
                            </div>
                            <div class="board-list-comment">
                                <span class="material-symbols-outlined">chat_bubble</span>
                                <span>\${qList.viewCount} 댓글</span>
                            </div>
                            </div>
                        </div>
                    `
                })
            })
            .catch(error => console.log(error))
        }
        qnaFun();
    </script>
</body>
</html>