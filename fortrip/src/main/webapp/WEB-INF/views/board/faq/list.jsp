<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>ForTrip - 자주 묻는 질문</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
    <link rel="stylesheet" href="/resources/css/common/header.css">
    <link rel="stylesheet" href="/resources/css/board/faq/faq.css">
    <link rel="stylesheet" href="/resources/css/common/rset.css">
    <style>
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>

    <div class="container">
        <!-- 왼쪽 사이드 메뉴 -->
        <aside class="sidebar">
            <ul>
                <li><a href="/board/notice/list">공지 사항</a></li>
                <li><a href="/board/faq/list" class="active">자주 묻는 질문</a></li>
                <li><a href="/board/qna/list">1:1 문의</a></li>
                <li><a href="/board/report/list">신고 게시판</a></li>
            </ul>
        </aside>

        <!-- FAQ 내용 -->
        <section class="content">
            <h2>자주 묻는 질문</h2>

            <div class="question-categories">
                <button class="active" data-code="all">전체보기</button>
                <button data-code="travel">여행 관련</button>
                <button data-code="user">회원 관련</button>
                <button data-code="community">커뮤니티 & 고객센터</button>
                <button data-code="review1">사이트 기능</button>
            </div>

            <div class="question-list">
                <c:forEach var="question" items="${faqList}">
                    <div class="question-item" data-category="${question.questionCategory}"> 
                        <%-- 카테고리별 필터링을 위해 data 속성 추가 --%>
                        <div class="faq-question">
                            Q. ${question.questionTitle}
                            <span class="toggle-icon">+</span>
                        </div>
                        <div class="faq-answer">
                            A. ${question.questionContent}
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty faqList}">
                    <p>등록된 질문이 없습니다.</p>
                </c:if>
            </div>
        </section>
    </div>

    <!-- footer -->
    <%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // 1. FAQ 아코디언 (질문 클릭 시 답변 열고 닫기) 기능

            // 페이지에 있는 모든 질문 요소
            const questions = document.querySelectorAll('.faq-question');

            // 각 질문 요소에 대해 클릭 이벤트
            questions.forEach(question => {
                question.addEventListener('click', () => {

                    // 클릭된 질문 바로 다음에 오는 답변 요소 찾기
                    const answer = question.nextElementSibling;

                    // 클릭된 질문 안에 있는 아이콘 요소 찾기
                    const icon = question.querySelector('.toggle-icon');

                    // 만약 클릭된 질문의 답변이 이미 열려있는 상태('show' 클래스를 가짐)라면,
                    if (answer.classList.contains('show')) {
                        answer.classList.remove('show');
                        icon.textContent = '+';
                    } else {
                        // 그렇지 않다면 (답변이 닫혀있다면),

                        // 1. 현재 열려있는 다른 모든 답변 먼저 닫기
                        document.querySelectorAll('.faq-answer.show').forEach(openAnswer => {
                            openAnswer.classList.remove('show');
                        });

                        // 2. 다른 모든 아이콘을 '+'로 초기화
                        document.querySelectorAll('.toggle-icon').forEach(openIcon => {
                            openIcon.textContent = '+';
                        });

                        // 3. 클릭된 질문의 답변만 열기
                        answer.classList.add('show');
                        icon.textContent = '×';
                    }
                });
            });

            // 2. 카테고리 필터 (버튼 클릭 시 해당 카테고리만 표시) 기능
            const categoryButtons = document.querySelectorAll('.question-categories button');
            // 페이지에 있는 모든 FAQ 아이템(질문+답변) 요소 출력
            const faqItems = document.querySelectorAll('.question-item');

            // 각 카테고리 버튼에 대해 클릭 이벤트 추가
            categoryButtons.forEach(button => {
                button.addEventListener('click', () => {

                    // 버튼 스타일 초기화 및 선택 처리
                    categoryButtons.forEach(btn => btn.classList.remove('active'));
                    button.classList.add('active');

                    // 버튼의 data-code 값 가져오기 (예: "travel")
                    const selectedCode = button.dataset.code;

                    faqItems.forEach(item => {
                        // DB에서 내려온 data-category 값 (예: "travel")
                        const itemCategory = item.dataset.category;

                        // 전체(all)이거나 코드 일치 시 표시
                        if (selectedCode === 'all' || itemCategory === selectedCode) {
                            item.style.display = 'block';
                        } else {
                            item.style.display = 'none';
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>
