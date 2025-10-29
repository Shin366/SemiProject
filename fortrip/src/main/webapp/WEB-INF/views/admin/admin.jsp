<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fortrip - 관리자 대시보드</title>
<link href="../../../resources/img/common/eyes-icon.png" rel="shortcut icon" type="image/x-icon">
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
                            <span>회원 활동 관리</span>
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
                            <span>게시물 관리</span>
                        </div>
                    </div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">help_center</span>
                            <span>공지사항 관리</span>
                        </div>
                    </div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">comment</span>
                            <span>신고 게시물 관리</span>
                        </div>
                    </div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">comment</span>
                            <span>문의글 관리</span>
                        </div>
                    </div>
                    <div class="menu-item">
                        <div class="menu-list">
                            <span class="material-symbols-outlined">comment</span>
                            <span>자주하는 질문 관리</span>
                        </div>
                    </div>
                </div>
                <div class="side-setting">
					<button type="button" id="topbtn" onclick="scrollToTop();"><span class="material-symbols-outlined">arrow_shape_up</span>맨 위로</button>
					<hr style="border: 1px solid #ccc;">
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
                                <span class="num">${getTravelCourseCount }</span>
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
                                <span class="label">비활성 회원수</span>
                            </div>
                        </div>
                        
                        <div id="userSearchForm">
                            <div class="search-container"> 
                                <span class="material-symbols-outlined">search</span>
                                <input type="text" name="userSearchInput" id="userSearchInput" placeholder="회원 이름 또는 아이디 검색">
                            </div>
                            <div id="userfilter">
							    <button id="btn">
							    <span class="material-symbols-outlined">filter_alt</span>필터</button>
							    <div id="userfilter-btn">							    	
									<button onclick="userListFun(1, 'active')" class="filter-btn">활성</button>
									<button onclick="userListFun(1, 'inactive')" class="filter-btn">비활성</button>
									<button onclick="userListFun(1, 'man')" class="filter-btn">남자</button>
									<button onclick="userListFun(1, 'girl')" class="filter-btn">여자</button>
								</div>
                            </div>
                        </div>
                        <div class="userAdd">
                            <button id="userAdd-btn" onclick="location.href='/admin/user/insert'">+ 회원 추가</button>
                        </div>
                        <div class="userInfo-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>회원 정보</th>
                                        <th>닉네임</th>
                                        <th>등급</th>
                                        <th>성별</th>
                                        <th>가입일</th>
                                        <th>전화번호</th>
                                        <th>상태</th>
                                        <th>작업</th>
                                    </tr>
                                </thead>
                                
                                <tbody id="userList"></tbody>
                                    
                                <tfoot>
                                    <tr>
                                        <td colspan="8">
                                            <nav class="pagination"></nav>
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
                        <div class="travelCourse-setting" id="travelCourse-setting">
                            <div class="setting-title">여행 코스 관리</div>
                            <form action="" id="course-searchForm">
                                <div class="search-course">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="코스명, 지역으로 검색..">
                                    <button type="button" id="courseAdd-btn" onclick="location.href='/trip/add'">+ 새 코스</button>
                                </div>
                            </form>
                            <div class="course-content">
                                <div class="course-card" data-id=\${rList.roadNo}>
			                        <div class="card-img"></div>
			                        <span class="course-title">\${rList.roadName}</span>
			                        <div class="card-info">
			                            <div class="card-header">
			                                <span>\${rList.roadStart}</span>→
			                                <span>\${rList.roadEnd}</span>→
			                                <span>경북궁</span>→
			                                <span>경북궁</span>
			                            </div>
			                            <div class="card-main">
			                                <div class="card-item">
			                                    <span class="material-symbols-outlined">location_on</span>
			                                    <span>\${rList.roadLocation}</span>
			                                </div>
			                                <div class="card-item">
			                                    <span class="material-symbols-outlined">schedule</span>
			                                    <span>7</span>
			                                </div>
			                                <div class="card-item">
			                                    <span class="material-symbols-outlined">star</span>
			                                    <span>4.8</span>
			                                </div>
			                                <div class="card-item">
			                                    <span class="material-symbols-outlined">credit_card</span>
			                                    <span>\${rList.roadCost}￦</span>
			                                </div>
			                            </div>
			                            <div class="card-footer">
			                                <span class="card-date">\${rList.writeDate} 등록</span>
			                                <div class="card-btn-row">
			                                    <a href="#" id="course-modify-btn">수정</a>
			                                    <input type="hidden" name="roadNo" value="\${rList.roadNo}">
			                                    <button type="button" onclick="travelDeleteFun(\${rList.roadNo});" id="course-delete-btn">삭제</button>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
                            </div>
                        </div>
                        <!--********************여행 코스 관리 끝******************-->

                        <!--********************관광지 관리******************-->
                        <div class="travelInfoSetting" id="travelInfoSetting">
                            <div class="travel-setting-title">관광지 관리</div>
                            <form action="" id="travel-searchForm">
                                <div class="travel-search-course">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="코스명, 지역으로 검색..">
                                    <button type="button" onclick="location.href='/tourist/insert'" id="travel-Add-btn">+ 새 관광지</button>
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
                                <span class="num">${getNoticeCount}</span>
                                <span class="label">공지사항</span>
                            </div>
                            <div class="allDeclarationBoard">
                                <span class="material-symbols-outlined" style="background-color:#cbc3e3; color: purple;">reviews</span>
                                <span class="num">${getReportCount }</span>
                                <span class="label">신고 게시물</span>
                            </div>
                            <div class="allInquiryBoard">
                                <span class="material-symbols-outlined" style="background-color:#f0c499; color: #ff7f00;">star</span>
                                <span class="num">${getQuestionCount}</span>
                                <span class="label">문의글</span>
                            </div>
                        </div>

                        <!--***********************게시물 관리*******************************-->
                        <div class="board-wrapper" id="board-set">
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
                        <div class="board-wrapper" id="notice-set">
                            <div class="board-title">공지사항 관리</div>                            
                             <div class="board-search-wrapper">
                                 <span class="material-symbols-outlined">search</span>
                                 <input type="text" id="noticeSearchInput" name="noticekeyword" placeholder="제목, 내용으로 검색..">
                                 <button type="button" id="notice-Add-btn" style="background-color: #ff7a00;" onclick="location.href='/notice/insert'">+ 새 공지사항</button>
                             </div>

                            <!-- 공지사항 리스트 -->
                            <div class="notice-content"></div>
                            <!-- 공지사항 페이징 -->
                            <div class="notice-pagination-wrapper">
                                <nav class="notice-pagination">
                                </nav>
                            </div>
                        </div>
                        <!--***********************공지사항 관리 끝*******************************-->

                        <!--***********************신고 게시물 관리*******************************-->
                        <div class="board-wrapper" id="declaration-set">
                            <div class="board-title">신고 게시물 관리</div>
                            <div id="board-search-form">
                                <div class="board-search-wrapper">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" id="reportSearchInput" name="reportSearchInput" placeholder="제목, 내용으로 검색..">
                                </div>
                            </div>

                            <div class="declaration-content"></div>
        
                            <div class="report-pagination-wrapper">
                                <nav class="report-pagination"></nav>
                            </div>
                        </div>
                        <!--***********************신고 게시물 관리 끝*******************************-->

                        <!--***********************문의글 관리*******************************-->
                        <div class="board-wrapper" id="inquiry-set">
                            <div class="board-title">문의글 관리</div>

                             <div class="board-search-wrapper">
                                 <span class="material-symbols-outlined">search</span>
                                 <input type="text" id="searchInput" name="keyword" placeholder="제목, 내용으로 검색..">
                             </div>


                           	<!-- 문의글 리스트 fetch API -->
                            <div class="qnaBoard-content"></div>
                     
                            <!-- 문의글 페이징 fetch API -->
                            <div class="qna-pagination-wrapper">
                                <nav class="qna-pagination"></nav>
                            </div>
                        </div>
                        <!--***********************문의글 관리 끝*******************************-->

                        <!--***********************자주하는 질문*******************************-->
                        <div class="question-wrapper" id="question-set">
                            <div class="question-row">
                            	<span>자주하는 질문 관리</span>
								<button type="button" id="question-Add-btn" onclick="location.href='/question/insert'">+ 새 질문</button>
                            </div>
       

                            <div class="question-content">
                                <div class="question-category">
                                    <ul>
                                        <li>
                                            <input type="radio" name="category" value="travel" id="travel-checkbox" checked >
                                            <label for="travel-checkbox">여행 관련</label>
                                        </li>
                                        <li>
                                            <input type="radio" name="category" value="user" id="user-checkbox">
                                            <label for="user-checkbox">회원 관련</label>
                                        </li>
                                        <li>
                                            <input type="radio" name="category" value="community" id="community-checkbox">
                                            <label for="community-checkbox">커뮤니티 & 고객센터</label>
                                        </li>
                                        <li>
                                            <input type="radio" name="category" value="review"  id="review-checkbox">
                                            <label for="review-checkbox">찜하기 및 리뷰</label>
                                        </li>
                                    </ul>
                                </div>

                                <!-- 자주하는 질문 리스트  -->
                                <div class="question-list"></div>
                                
                            </div>
                        </div>
                        <!--***********************자주하는 질문 관리 끝*******************************-->
                        </div>
                </section>
            </section>
        </section>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
    <script src="../../../resources/css/admin/js/List-move.js"></script>
    <script>
    /* 회원 리스트 */
    document.querySelector("#userSearchInput").addEventListener("keydown", (e) => {
    	const userSearchInput = document.querySelector("#userSearchInput");
    	if(e.key == "Enter"){
    		e.preventDefault();
    		const keyword = userSearchInput.value.trim(); // 키워드를 먼저 읽어옵니다.
    		userListFun(1, "", keyword); // filter는 비우고 keyword를 전달합니다.
    		userSearchInput.value = "";
    	}
    });
    
    function userListFun(currentPage = 1, filter="", keyword="") {
    	//const keyword = document.querySelector("#userSearchInput").value.trim();
    	let options, url;
    	
    	if(keyword) {
    		url = "/admin/user/search";
    		options = {
   				method: "POST",
   				headers: {"Content-Type": "application/x-www-form-urlencoded"},
   				body: new URLSearchParams({ page: currentPage, keyword }), 
    		};
    	} else if (filter) {
    		url = "/admin/user/filter";
    	    options = {
    	      method: "POST",
    	      headers: { "Content-Type": "application/x-www-form-urlencoded" },
    	      body: new URLSearchParams({ page: currentPage, filter }),
    	    };
   	    } else {
   	      url = "/admin/user/list?page=" + currentPage;
   	      options = {};
   	    }
    	
    	fetch(url, options)
    	.then(res => res.json())
    	.then(data => {
    		console.log(data)
    		const userList = document.querySelector("#userList")
    		userList.innerHTML = "";
    		
   	      if (!data.mList || data.mList.length === 0) {
   	          userList.innerHTML = `
   	            <tr>
   	              <td colspan="8" style="height: 200px; text-align: center; color:#666; font-weight:bold;">
   	                검색 결과가 없습니다.
   	              </td>
   	            </tr>
   	          `;
   	          return;
   	        }
   	      
    		data.mList.forEach(m => {
    			const adminClass = m.adminYn === "Y" ? "admin" : "user";
    			const adminText = m.adminYn === "Y" ? "관리자" : "일반 회원";
    			const genderText = m.gender === "M" ? "남자" : "여자";
    			
                let statusClass = "";
                let statusText = "";
                
                if (m.statusYsn === "Y") {
                    statusClass = "active";
                    statusText = "활성";
                } else if (m.statusYsn === "S") {
                    statusClass = "inactive";
                    statusText = "비활성";
                } else {
                	statusClass = "stop";
                    statusText = "회원 탈퇴";
                }
                
    			userList.innerHTML += `  
	    				<tr>
	                    <td>
	                        <div class="profile-cell">
	                            <div class="profile-info">
	                                <span class="name">\${m.memberName}</span>
	                                <span class="email">\${m.email}</span>
	                            </div>
	                        </div>
	                    </td>
	                    <td>\${m.nickName}</td>
	                    <td><span class="status \${adminClass}">\${adminText}</span></td>
	                    <td>\${genderText}</td>
	                    <td>\${m.enrollDate}</td>
	                    <td>\${m.phone}</td>
	                    <td><span class="status \${statusClass}">\${statusText}</span></td>
	                    <td>
	                    	<button type="button" onclick="location.href='/admin/user/modify?memberNo=\${m.memberNo}'" class="action-link">수정</button>	                       
	                        <button type="button" onclick="userDelete(\${m.memberNo});"class="action-link danger">탈퇴</button>
	                    </td>
	                </tr>
    			`;
    		});
    		
            const pagination = document.querySelector(".pagination");
		    if(pagination) {
		    	pagination.innerHTML = "";
				
			    let pageHtml = '';
			    
			    // 이전 버튼
                if (data.startNavi > 1) {
                    pageHtml += `<button class="prev" onclick="userListFun(\${data.startNavi - 1}, '\${filter}', '\${keyword}')">\&laquo;이전</button>`;
                }

                // 페이지 번호
                for (let i = data.startNavi; i <= data.endNavi; i++) {
                    if (i === data.currentPage) {
                        pageHtml += `<button class="page-number active" onclick="userListFun(\${i}, '\${filter}', '\${keyword}')">\${i}</button>`;
                    } else {
                        pageHtml += `<button class="page-number" onclick="userListFun(\${i}, '\${filter}', '\${keyword}')">\${i}</button>`;
                    }
                }

                // 다음 버튼
                if (data.endNavi < data.maxPage) {
                    pageHtml += `<button class="next" onclick="userListFun(\${data.endNavi + 1}, '\${filter}', '\${keyword}')">다음&raquo;</button>`;
                }
			    pagination.innerHTML = pageHtml;
		    }
    	})
    	.catch(error => console.log(error))
    }

    function userDelete(memberNo) {
    	if(!confirm("정말로 탈퇴처리를 하시겠습니까?")) return;
    	fetch("/admin/user/delete?memberNo=" + memberNo)
    	.then(res => res.json())
    	.then(result => {
    		if(result > 0) {
    			alert("회원 탈퇴 처리 완료");
    			userListFun(1);
    		} else {
    			alert("회원 탈퇴 처리 실패");
    		}
    	})
    	.catch(error => console.log(error));
    }
    userListFun(1);
    /* 회원 리스트 끝 */
    
    /* 인기 키워드 차트 */
   	function keywordChart() {
    	fetch("/admin/hot/keyword")
    	.then(res => res.json())
    	.then(data => {
    		console.log(data);
    		const labels = data.map(d => d.KEYWORD);
    		const counts = data.map(d => d.COUNT);
    		
    		new Chart(document.querySelector("#keywordChart"), {
    			type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '검색횟수',
                        data: counts,                                             
                	}]
                },
    		});
    	})
    	.catch(error => console.log(error));
    }
   	keywordChart();
    /* 인기 키워드 차트 끝 */
    
    /* 회원 가입 현황 차트 */
    function signupChart() {
        fetch("/admin/signup/chart")
            .then(res => res.json())
            .then(data => {
            	console.log(data);
                const labels = data.map(d => d.MONTH);
                const counts = data.map(d => d.JOIN_COUNT);
                
                new Chart(document.querySelector("#userChart"), {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '회원가입 수 ',
                            data: counts,                                             
                        }]
                    },
                });
            })
            .catch(error => console.error('차트 데이터 로드 실패:', error));
    	}
	    signupChart();
	    /* 회원 가입 현황 차트 끝 */
	    
    	/* 여행관련 자주하는 질문 */
   		function questionCategory() {
            const checked = document.querySelector(".question-category input[type='radio']:checked");
            const category = checked ? checked.value : '';
            console.log("선택된 카테고리:", category); // 디버깅용
            return category;
        }
        
        function questionFun() {      
            const category = questionCategory();
            if (!category) {
                document.querySelector(".question-list").innerHTML = '<p style="text-align: center;">표시할 카테고리를 선택해주세요.</p>';
                return;
            }
            fetch("/question/list?category=" + category) 
                .then(response => response.json())
                .then(qList => {
                	console.log("번호",qList.questionNo);
                    const questionList = document.querySelector(".question-list");
                    questionList.innerHTML = ''; 
                    
                    if (qList.length === 0) {
                        questionList.innerHTML = `
                        <div style="height: 200px; display:flex; align-items:center; justify-content: center;">
                        	<p style="text-align: center; font-weight: bold; padding: 10px 20px; color:#666">해당 카테고리의 질문이 없습니다.</p>
                        </div>
                        `
                        return;
                    }
        
                    qList.forEach(question => {
                        questionList.innerHTML += `
                            <div class="question-item"> 
                                <div class="question-list-header">
                                    <div class="question-title">
                                        <h4><span>Q.</span>\${question.questionTitle}</h4>
                                    </div>
                                    <div class="question-btn">
                                        <a href="/question/modify?questionNo=\${question.questionNo}" class="edit-btn">수정</a>
                                        <input type="hidden" name="questionNo" value="\${question.questionNo}">
                                        <button type="button" class="delete-btn" onclick="questionDelete(\${question.questionNo})">삭제</button>
                                    </div>
                                </div>
                                <div class="question-list-content">
                                    <p><span>A. </span>\${question.questionContent}</p>
                                </div>
                            </div>`;
                    });
                })
                .catch(error => {
                    console.error("Fetch Error:", error);          
                    document.querySelector(".question-list").innerHTML = `
                    	<div style="height: 200px; display:flex; align-items:center; justify-content: center;">
	                    	<p style="text-align: center; font-weight: bold; color: #dc2626;">데이터 로드 중 오류 발생</p>
                    	</div>
                    	`
                });
        }
        
        const categoryBox = document.querySelector(".question-category");
        if (categoryBox) {
            categoryBox.addEventListener('change', questionFun);
        }
        questionFun();
        												
        function questionDelete(questionNo) {
        	console.log(questionNo);
        	if(!confirm("정말 삭제하시겠습니까?")) return;
        	fetch("/question/delete?questionNo=" + questionNo)
        	.then(response => response.json())
			.then(result => {
				if(result > 0) {
					alert("삭제 완료");
					questionFun();
				} else {
					alert("삭제 실패");
				}
			})
			.catch(error => alert(error));
        };
		/* 여행관련 자주하는 질문 끝 */
		
        
        /*  공지  */
		document.querySelector("#noticeSearchInput").addEventListener("keydown", (e) => {
	        const noticeSearchInput = document.querySelector("#noticeSearchInput");
        	if(e.key == "Enter") {
        		e.preventDefault();
        		noticeFun(1);
        		noticeSearchInput.value = "";
        	}
		});
		
        function noticeFun(currentPage = 1) {
        	const keyword = document.querySelector("#noticeSearchInput").value.trim();
        	const url = keyword ? "/notice/search/list" : "/notice/list?page=" + currentPage; 
        	const options = keyword
            ? {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({ page: currentPage, keyword }),
              }
            : {};
            fetch(url, options)
            .then(response => response.json())
            .then(data => {
                const noticeList = document.querySelector(".notice-content");
                noticeList.innerHTML='';
                
                if (!data.nList || data.nList.length === 0) {
                	const pagination = document.querySelector(".notice-pagination");
                	pagination.innerHTML = '';
                	noticeList.innerHTML = `
		                <div style="height: 200px; display:flex; align-items:center; justify-content: center;">
		                  <p style="text-align: center; font-weight: bold; padding: 10px 20px; color:#666">
		                    검색 결과가 없습니다.
		                  </p>
		                </div>
		              `;
		              return; 
		            }
		
                data.nList.forEach(notice => {
                    noticeList.innerHTML+=`
                        <div class="board-list" style="background-color: #fff5ef">
                            <div class="board-list-header">
                                <div class="board-category">
                                    <p style="background-color: #ff7a00;">공지사항</p>
                                </div>
                                <div class="board-date">\${notice.writerDate}</div>
                                <div class="board-btn">
                                    <button class="edit-btn" onclick="location.href='/notice/modify?noticeNo=\${notice.noticeNo}'">수정</button>
                                    <button type="button" class="delete-btn" onclick="noticeDelete(\${notice.noticeNo})">삭제</button>
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
                });
                
                 const pagination = document.querySelector(".notice-pagination");
				    if(pagination) {
				    	pagination.innerHTML = "";
						
					    let pageHtml = '';
					    
					    // 이전 버튼
		                if (data.startNavi > 1) {
		                    pageHtml += `<button class="prev" onclick="noticeFun(\${data.startNavi - 1})">\&laquo;이전</button>`;
		                }

		                // 페이지 번호
		                for (let i = data.startNavi; i <= data.endNavi; i++) {
		                    if (i === data.currentPage) {
		                        pageHtml += `<button class="page-number active" onclick="noticeFun(\${i})">\${i}</button>`;
		                    } else {
		                        pageHtml += `<button class="page-number" onclick="noticeFun(\${i})">\${i}</button>`;
		                    }
		                }

		                // 다음 버튼
		                if (data.endNavi < data.maxPage) {
		                    pageHtml += `<button class="next" onclick="noticeFun(\${data.endNavi + 1})">다음&raquo;</button>`;
		                }
					    pagination.innerHTML = pageHtml;
				    }
            })
            .catch(error => console.log(error))
        }
        
        function noticeDelete(noticeNo) {
        	if(!confirm("정말 삭제하시겠습니까?")) return;
        	fetch("/notice/delete?noticeNo=" + noticeNo)
        	.then(res => res.json())
        	.then(result => {
        		if(result > 0) {
        			alert("공지 삭제 완료");
        			noticeFun();
        		} else {
        			alert("공지 삭제 실패");
        		}
        	})
        	.catch(error => console.log(error));
        }
        noticeFun(1);
        /*  공지 끝  */
        
        /*  문의글  */
        document.querySelector("#searchInput").addEventListener("keydown", e => {
	        const qnaSearchInput = document.querySelector("#searchInput");
        	if(e.key == "Enter") {
        		e.preventDefault();
        		qnaFun(1);
        		qnaSearchInput.value = "";
        	}
        })
        
		function qnaFun(currentPage = 1) {
			const keyword = document.querySelector("#searchInput").value.trim();
        	const url = keyword ? "/qna/search/list" : "/qna/list?page=" + currentPage;
        	 
        	const options = keyword
            ? {
                method: "POST",
                headers: { "Content-Type": "application/x-www-form-urlencoded" },
                body: new URLSearchParams({ page: currentPage, keyword }),
              }
            : {};
            
		    fetch(url, options)
		        .then(response => response.json())
		        .then(data => {		        	
		            const qnaBoardList = document.querySelector(".qnaBoard-content");
		            qnaBoardList.innerHTML = "";
		            

		            if (!data.qList || data.qList.length === 0) {
		              qnaBoardList.innerHTML = `
		                <div style="height: 200px; display:flex; align-items:center; justify-content: center;">
		                  <p style="text-align: center; font-weight: bold; padding: 10px 20px; color:#666">
		                    검색 결과가 없습니다.
		                  </p>
		                </div>
		              `;
		              return; 
		            }
		
		            data.qList.forEach(qList => {
		                qnaBoardList.innerHTML += `
		                    <div class="board-list" style="background-color: #D9FFD9;">
		                        <div class="board-list-header">
		                            <div class="board-category">
		                                <p style="background-color: #059905;">문의글</p>
		                            </div>
		                            <div class="board-date">\${qList.writeDate}</div>
		                            <div class="board-btn">
		                                <button type="button" onclick="qnaDelete(\${qList.qnaNo});"class="delete-btn">삭제</button>
		                            </div>
		                        </div>
		                        <div class="board-list-title">
		                            <span>\${qList.qnaTitle}</span>
		                        </div>
		                        <div class="board-list-detail">\${qList.qnaContent}</div>
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
		                `;
		            });
		            
				    const pagination = document.querySelector(".qna-pagination");
				    if(pagination) {
				    	pagination.innerHTML = "";
						
					    let pageHtml = '';
					    
					    // 이전 버튼
		                if (data.startNavi > 1) {
		                    pageHtml += `<button class="prev" onclick="qnaFun(\${data.startNavi - 1})">\&laquo;이전</button>`;
		                }

		                // 페이지 번호
		                for (let i = data.startNavi; i <= data.endNavi; i++) {
		                    if (i === data.currentPage) {
		                        pageHtml += `<button class="page-number active" onclick="qnaFun(\${i})">\${i}</button>`;
		                    } else {
		                        pageHtml += `<button class="page-number" onclick="qnaFun(\${i})">\${i}</button>`;
		                    }
		                }

		                // 다음 버튼
		                if (data.endNavi < data.maxPage) {
		                    pageHtml += `<button class="next" onclick="qnaFun(\${data.endNavi + 1})">다음&raquo;</button>`;
		                }
					    pagination.innerHTML = pageHtml;
				    }
				    
		        })
		        .catch(error => console.error('데이터 불러오기 오류:', error));
		    
		}
		qnaFun();
        /*  문의글 끝  */
        
        /* 문의 글 삭제 */
        function qnaDelete(qnaNo) {
        	if(!confirm("정말 삭제하시겠습니까?")) return;
        	fetch("/qna/delete?qnaNo=" + qnaNo)
        	.then(res => res.json())
        	.then(result => {
        		if(result > 0) {
        			alert("삭제 완료");
        			qnaFun();
        		} else {
        			alert("삭제 실패");
        		}
        	})
        	.catch(error => alert(error));
        }
        /* 문의 글 삭제 끝 */
        
        /* 여행 코스 */
        function travelCourseFun() {
        	fetch("/road/list")
        	.then(response => response.json())
        	.then(road => {
        		console.log("로드 번호",road.roadNo);
        		const roadList = document.querySelector(".course-content");
        		roadList.innerHTML = "";
        		
        		road.forEach(rList => {
        			roadList.innerHTML += `
        			<div class="course-card" data-id=\${rList.roadNo}>
                        <div class="card-img"></div>
                        <span class="course-title">\${rList.roadName}</span>
                        <div class="card-info">
                            <div class="card-header">
                                <span>\${rList.roadStart}</span>→
                                <span>\${rList.roadEnd}</span>→
                                <span>경북궁</span>→
                                <span>경북궁</span>
                            </div>
                            <div class="card-main">
                                <div class="card-item">
                                    <span class="material-symbols-outlined">location_on</span>
                                    <span>\${rList.roadLocation}</span>
                                </div>
                                <div class="card-item">
                                    <span class="material-symbols-outlined">schedule</span>
                                    <span>7</span>
                                </div>
                                <div class="card-item">
                                    <span class="material-symbols-outlined">star</span>
                                    <span>4.8</span>
                                </div>
                                <div class="card-item">
                                    <span class="material-symbols-outlined">credit_card</span>
                                    <span>\${rList.roadCost}￦</span>
                                </div>
                            </div>
                            <div class="card-footer">
                                <span class="card-date">\${rList.writeDate} 등록</span>
                                <div class="card-btn-row">
                                    <a href="#" id="course-modify-btn">수정</a>
                                    <input type="hidden" name="roadNo" value="\${rList.roadNo}">
                                    <button type="button" onclick="travelDeleteFun(\${rList.roadNo});" id="course-delete-btn">삭제</a>
                                </div>
                            </div>
                        </div>
                    </div>
        			`;
        		})
        	})
        	.catch(error => alert(error));
        }
        travelCourseFun();
        /* 여행 코스 끝 */
        
        /* 여행 코스 삭제 */
        function travelDeleteFun(roadNo) {
        	if(!confirm("정말 삭제하시겠습니까?")) return;
        	console.log("불러온 로드 번호",roadNo);
        	fetch("/road/delete?roadNo=" + roadNo)
        	.then(response => response.json())
        	.then(result => {
        		if(result > 0) {
        			alert("삭제 완료");
        			travelCourseFun();
        		} else {
        			alert("삭제 실패");
        		}
        	})
        	.catch(error => alert(error));
        };
        /* 여행 코스 삭제 끝 */
        
        /* 신고게시판 */ 
        document.querySelector("#reportSearchInput").addEventListener("keydown", (e) => {
	        const reportSearchInput = document.querySelector("#reportSearchInput");
        	if(e.key == "Enter") {
        		e.preventDefault();
        		reportList(1);
        		reportSearchInput.value = "";
        	}
		});
        function reportList(currentPage = 1) { 
	        const keyword = document.querySelector("#reportSearchInput").value.trim();
	    	const url = keyword ? "/report/search/list" : "/report/list?page=" + currentPage; 
	    	const options = keyword
	        ? {
	            method: "POST",
	            headers: { "Content-Type": "application/x-www-form-urlencoded" },
	            body: new URLSearchParams({ page: currentPage, keyword }),
	          }
	        : {};
        	fetch(url, options)
        	.then(res => res.json())
        	.then(data => {
        		const reportList = document.querySelector(".declaration-content")
        		reportList.innerHTML ="";
        		
        		 if (!data.rList || data.rList.length === 0) {
        			 reportList.innerHTML = `
		                <div style="height: 200px; display:flex; align-items:center; justify-content: center;">
		                  <p style="text-align: center; font-weight: bold; padding: 10px 20px; color:#666">
		                    검색 결과가 없습니다.
		                  </p>
		                </div>
		              `;
		              return;
		            }
        		 
        		data.rList.forEach(rList => {
        			reportList.innerHTML = `
        				<div class="board-list" style="background-color: #FFD0D0;">
                        <div class="board-list-header">
                        <div class="board-category">
                            <p style="background-color: #DC2626;">신고 게시판</p>
                        </div>
                        <div class="board-date">\${rList.writeDate}</div>
                        </div>

                        <div class="board-list-title">
                        <span>\${rList.reportTitle}</span>
                        </div>

                        <div class="board-list-detail">
                        \${rList.reportContent}
                        </div>
                    </div>
        			`;
        		});
        		const pagination = document.querySelector(".report-pagination");
			    if(pagination) {
			    	pagination.innerHTML = "";
					
				    let pageHtml = '';
				    
				    // 이전 버튼
	                if (data.startNavi > 1) {
	                    pageHtml += `<button class="prev" onclick="reportList(\${data.startNavi - 1})">\&laquo;이전</button>`;
	                }

	                // 페이지 번호
	                for (let i = data.startNavi; i <= data.endNavi; i++) {
	                    if (i === data.currentPage) {
	                        pageHtml += `<button class="page-number active" onclick="reportList(\${i})">\${i}</button>`;
	                    } else {
	                        pageHtml += `<button class="page-number" onclick="reportList(\${i})">\${i}</button>`;
	                    }
	                }

	                // 다음 버튼
	                if (data.endNavi < data.maxPage) {
	                    pageHtml += `<button class="next" onclick="reportList(\${data.endNavi + 1})">다음&raquo;</button>`;
	                }
				    pagination.innerHTML = pageHtml;
			    }			          		
        	})
        	.catch(error => console.log(error));
        }
        reportList(1);
        /* 신고게시판 끝 */ 
        
        /***************************/
        const filterBox = document.querySelector("#userfilter-btn");
        const filterBtn = document.querySelector("#btn");
	  
	    filterBtn.addEventListener("click", () => {
	      filterBox.style.display = (filterBox.style.display === "flex") ? "none" : "flex";
	    });
	
	    function applyFilter(filterType, clickedBtn) {
	      document.querySelectorAll(".filter-btn").forEach(btn => btn.classList.remove("active"));
	      clickedBtn.classList.add("active");  
	      userListFun(1, filterType);
	      filterBox.style.display = "none";
	    }

	    document.addEventListener("click", (e) => {
	      if (!document.querySelector("#userfilter").contains(e.target)) {
	        filterBox.style.display = "none";
	      }
	    });
    </script>
</body>
</html>