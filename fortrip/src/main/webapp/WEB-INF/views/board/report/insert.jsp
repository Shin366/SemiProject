<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고게시판 - 작성</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/common/header.css'/>">
	<link rel="stylesheet" href="<c:url value='/resources/css/board/report/insert.css'/>">
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="report-container">
        <div class="report-card">
            <div class="card-header">
                <h2><i class="fa-solid fa-triangle-exclamation"></i> 신고하기</h2>
            </div>

            <form id="reportForm" action="<c:url value='/board/report/insert'/>" method="post" enctype="multipart/form-data">

                <!-- 제목 입력란 제거 (Service에서 "신고합니다"로 설정) -->
                <div class="form-section">
                    <h3>신고 사유 <span style="color:red;">*</span></h3>
                    <p class="description">해당하는 신고 사유를 선택해주세요.</p>
                    <div class="radio-group">
                        <%-- name을 DTO 필드명(reportReason)과 일치 --%>
                        <label><input type="radio" name="reportReason" value="SPAM" required> 스팸 홍보 / 도배 <span class="checkmark"></span></label>
                        <label><input type="radio" name="reportReason" value="OBSCENE"> 음란물 <span class="checkmark"></span></label>
                        <label><input type="radio" name="reportReason" value="ILLEGAL"> 불법 정보 <span class="checkmark"></span></label>
                        <label><input type="radio" name="reportReason" value="ABUSE"> 욕설/비방/혐오 <span class="checkmark"></span></label>
                        <label><input type="radio" name="reportReason" value="PRIVACY"> 개인정보 노출 <span class="checkmark"></span></label>
                        <label><input type="radio" name="reportReason" value="INAPPROPRIATE"> 불쾌한 표현 <span class="checkmark"></span></label>
                    </div>
                </div>

                <div class="form-section">
                    <h3>상세 내용 <span style="color:red;">*</span></h3>
                    <p class="description">신고할 게시물 주소(URL)와 함께 어떤 점이 문제인지 자세히 알려주세요.</p>
                    <div class="form-group">
                        <textarea id="reportContent" name="reportContent" rows="7" placeholder="예시)&#10;게시물 주소: https://...&#10;신고 내용: 댓글 내용 중 심한 욕설 포함" required></textarea>
                    </div>
                </div>

                <div class="form-section">
                     <h3>첨부 파일 (선택)</h3>
                     <p class="description">문제가 되는 부분을 캡처하여 첨부하면 처리에 도움이 됩니다.</p>
                     <div class="form-group attachment-group">
                        <input type="file" id="files" name="files" multiple>
                    </div>
                </div>

                <div class="form-section">
                    <h3>열람용 비밀번호 <span style="color:red;">*</span></h3>
                    <p class="description">작성하신 신고 내용과 답변을 확인하기 위한 숫자 4자리 비밀번호입니다.</p>
                    <div class="password-group">
                        <div class="form-group">
                             <label for="reportPassword">비밀번호 설정</label>
                             <input type="password" id="reportPassword" name="reportPassword" maxlength="4" pattern="\d{4}" title="숫자 4자리만 입력 가능합니다." placeholder="숫자 4자리" required>
                        </div>
                        <div class="form-group">
                             <label for="passwordConfirm">비밀번호 확인</label>
                             <input type="password" id="passwordConfirm" maxlength="4" placeholder="한 번 더 입력" required>
                        </div>
                    </div>
                </div>

                <div class="button-group">
                    <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-primary">제출하기</button>
                </div>

            </form>
        </div>
    </div>

<script>
    document.getElementById('reportForm').addEventListener('submit', function(event) {
        event.preventDefault(); // 기본 제출 막기

        // 입력 값 가져오기
        const password = document.getElementById('reportPassword').value; // ID 수정 반영
        const passwordConfirm = document.getElementById('passwordConfirm').value;
        const content = document.getElementById('reportContent').value.trim();
        const reason = document.querySelector('input[name="reportReason"]:checked');

        // 유효성 검사
        if (!reason) {
            alert('신고 사유를 선택해주세요.'); return;
        }
        if (content === '') {
            alert('상세 내용을 입력해주세요.');
            document.getElementById('reportContent').focus(); return;
        }
        const passwordRegex = /^\d{4}$/;
        if (!passwordRegex.test(password)) {
            alert('비밀번호는 숫자 4자리로 설정해야 합니다.');
            document.getElementById('reportPassword').focus(); return;
        }
        if (password !== passwordConfirm) {
            alert('비밀번호가 일치하지 않습니다.');
            document.getElementById('passwordConfirm').focus(); return;
        }

        // 검사 통과 시 폼 제출
        console.log('유효성 검사 통과. 폼을 제출합니다.');
        this.submit();
    });
</script>

</body>
</html>