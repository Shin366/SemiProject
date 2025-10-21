<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fortrip - 관리자 대시보드</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
<link rel="stylesheet" href="../resources/css/admin/main.css">
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

                <section id="userSetting">
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
                                        <th>성별</th>
                                        <th>가입일</th>
                                        <th>전화번호</th>
                                        <th>상태</th>
                                        <th>작업</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                	<c:forEach var="mList" items="${mList }">
	                                    <tr>
	                                        <td>
	                                            <div class="profile-cell">
	                                            <img src="../img/son.png" alt="김여행자 프로필">
	                                            <div class="profile-info">
	                                                <span class="name">${m.memberName}</span>
	                                                <span class="email">${m.email }</span>
	                                            </div>
	                                            </div>
	                                        </td>
	                                        <td>${m.gender}</td>
	                                        <td>${m.enrollDate }</td>
	                                        <td>${m.phone }</td>
	                                        <td><span class="status active">${m.active }</span></td>
	                                        <td>
	                                            <a href="#" class="action-link">수정</a>
	                                            <a href="#" class="action-link danger">정지</a>
	                                        </td>
	                                    </tr>
                                 	</c:forEach>   
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <td colspan="7">
                                            <nav class="pagination">
                                                <a href="#">이전</a>
                                                <a href="#">1</a>
                                                <a href="#">2</a>
                                                <a href="#">3</a>
                                                <a href="#">다음</a>
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
                        <div class="travelCourse-setting">
                            <div class="setting-title">여행 코스</div>
                            <form action="" id="course-searchForm">
                                <div class="search-course">
                                    <span class="material-symbols-outlined">search</span>
                                    <input type="text" placeholder="코스명, 지역으로 검색..">
                                    <button id="courseAdd-btn">+ 새 코스</button>
                                </div>
                            </form>
                            
                            <div class="card-list">
                                <div class="travel-card">
                                    <div class="travel-image">
                                        <img src="../resources/img/admin/seoul-img.png" alt="">
                                    </div>
                                    <div class="travel-container">
                                        <h3 class="travel-title">서울 도심 문화탐방 코스</h3>
                                        <p class="travel-route">경복궁 → 북촌한옥마을 → 인사동 → 명동</p>
                                    </div>
                                    <div class="travel-footer">
                                        <span class="registration-date">2024.03.15 등록</span>
                                        <div class="action-links">
                                            <a href="#">수정</a>
                                            <span class="separator">|</span>
                                            <a href="#" class="delete-link">삭제</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="travelInfoSetting">
                            <span>관광 정보</span>
                        </div>
                    </div>
                </section>
            </section>
        </section>
	</div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.0/chart.umd.min.js"></script>
	<script>
		let keyChart = document.querySelector("#keywordChart");
	
	    let kChart = new Chart(keyChart, {
	        type: 'bar',
	        data: {
	            labels: ['제주도', '부산', '전주', '서울'],
	            datasets: [
	            {
	                label: '검색 횟수',
	                data: [10,20,30,40],
	            }
	            ]
	        },
	    });

		let userChart = document.querySelector("#userChart");
		
		let uChart = new Chart(userChart, {
		    type: 'line',
		    data: {
		        labels: ['1분기', '2분기', '3분기', '4분기'],
		        datasets: [
		        {
		            label: '가입자',
		            data: [10,30,60,50],
		        }
		        ]
		    },
		});
		document.addEventListener("DOMContentLoaded", () => {
			  // 메뉴 항목을 모두 선택
			  const menuItems = document.querySelectorAll(".menu-item .menu-list");

			  menuItems.forEach((item) => {
			    item.addEventListener("click", () => {
			      const text = item.innerText.trim(); // 메뉴 이름 텍스트로 판단

			      let targetId;

			      // 메뉴 이름에 따라 이동할 섹션 ID 설정
			      if (text.includes("통계 개요")) targetId = "dashboard";
			      else if (text.includes("회원") || text.includes("정지")) targetId = "userSetting";
			      else if (text.includes("여행") || text.includes("관광")) targetId = "content";
			      else return; // 해당되지 않으면 아무 동작 안 함

			      const target = document.getElementById(targetId);
			      if (target) {
			        target.scrollIntoView({ behavior: "smooth", block: "start" });
			      }
			    });
			  });
			});

	</script>
</body>
</html>