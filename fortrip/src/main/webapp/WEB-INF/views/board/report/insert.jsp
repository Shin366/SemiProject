<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고게시판 - 작성</title>
    <%-- 외부 CSS 링크 사용 시 c:url 사용 권장 --%>
	<%-- <link rel="stylesheet" href="<c:url value='/resources/css/common/header.css'/>"> --%>
    <style>
        /* --- 기본 & 레이아웃 --- */
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif; background-color: #f8f9fa; margin: 0; padding: 20px; color: #343a40; }
        .report-container { max-width: 800px; width: 100%; margin: 40px auto; background-color: #ffffff; border-radius: 8px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); overflow: hidden; /* 카드 내부 요소가 넘치지 않도록 */ }
        .report-card { padding: 40px 50px; }

        /* --- 헤더 --- */
        .card-header h2 { margin: 0 0 30px 0; font-size: 26px; font-weight: 700; color: #212529; border-bottom: 1px solid #e0e0e0; padding-bottom: 20px; display: flex; align-items: center; gap: 10px;}
        .card-header h2 i { color: #007bff; } /* 아이콘 색상 */

        /* --- 폼 섹션 --- */
        .form-section { margin-bottom: 35px; }
        .form-section h3 { font-size: 18px; margin-bottom: 15px; font-weight: 600; color: #343a40; }
        .form-section p.description { font-size: 14px; color: #6c757d; margin: 0 0 15px; line-height: 1.6; }

        /* 라디오 버튼 */
        .radio-group label { display: block; margin-bottom: 12px; font-size: 16px; cursor: pointer; position: relative; padding-left: 30px; }
        .radio-group input[type="radio"] { position: absolute; opacity: 0; cursor: pointer; }
        .radio-group label .checkmark { position: absolute; top: 2px; left: 0; height: 18px; width: 18px; background-color: #eee; border-radius: 50%; border: 1px solid #ccc; transition: all 0.2s; }
        .radio-group label:hover input ~ .checkmark { background-color: #ccc; }
        .radio-group label input:checked ~ .checkmark { background-color: #007bff; border-color: #007bff; }
        .radio-group label .checkmark:after { content: ""; position: absolute; display: none; top: 5px; left: 5px; width: 8px; height: 8px; border-radius: 50%; background: white; }
        .radio-group label input:checked ~ .checkmark:after { display: block; }

        /* 입력 필드 */
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; color: #495057; font-size: 15px; }
        input[type="text"], input[type="password"], textarea { width: 100%; padding: 12px 15px; border: 1px solid #ced4da; border-radius: 6px; font-size: 16px; box-sizing: border-box; transition: border-color 0.2s, box-shadow 0.2s; }
        input[type="text"]:focus, input[type="password"]:focus, textarea:focus { outline: none; border-color: #80bdff; box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25); }
        textarea { resize: vertical; min-height: 120px; }
        input[type="file"] { border: none; padding-left: 0; }

        /* 비밀번호 그룹 */
        .password-group { display: flex; gap: 20px; }
        .password-group .form-group { flex: 1; }

        /* 버튼 그룹 */
        .button-group { text-align: right; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e9ecef; }
        .btn { padding: 10px 20px; border: none; border-radius: 6px; font-size: 16px; cursor: pointer; text-decoration: none; display: inline-block; font-weight: 500; transition: background-color 0.2s; }
        .btn-secondary { background-color: #6c757d; color: white; margin-right: 10px; }
        .btn-secondary:hover { background-color: #5a6268; }
        .btn-primary { background-color: #007bff; color: white; }
        .btn-primary:hover { background-color: #0056b3; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <div class="report-container">
        <div class="report-card">
            <div class="card-header">
                <h2><i class="fa-solid fa-triangle-exclamation"></i> 신고하기</h2> <%-- 아이콘 추가 --%>
            </div>

            <form id="reportForm" action="<c:url value='/board/report/insert'/>" method="post" enctype="multipart/form-data">

                <%-- 제목 입력란 제거 (Service에서 "신고합니다"로 설정) --%>

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
                        <%-- name을 DTO 필드명(reportContent)과 일치 --%>
                        <textarea id="reportContent" name="reportContent" rows="7" placeholder="예시)&#10;게시물 주소: https://...&#10;신고 내용: 댓글 내용 중 심한 욕설 포함" required></textarea>
                    </div>
                </div>

                <div class="form-section">
                     <h3>첨부 파일 (선택)</h3>
                     <p class="description">문제가 되는 부분을 캡처하여 첨부하면 처리에 도움이 됩니다.</p>
                     <div class="form-group attachment-group">
                         <%-- name을 Controller 파라미터(files)와 일치, multiple 추가 --%>
                        <input type="file" id="files" name="files" multiple>
                    </div>
                </div>

                <div class="form-section">
                    <h3>열람용 비밀번호 <span style="color:red;">*</span></h3>
                    <p class="description">작성하신 신고 내용과 답변을 확인하기 위한 숫자 4자리 비밀번호입니다.</p>
                    <div class="password-group">
                        <div class="form-group">
                             <label for="reportPassword">비밀번호 설정</label>
                             <%-- id/name을 DTO 필드명(reportPassword)과 일치 --%>
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
        // HTML5 pattern 속성으로 대체 가능하지만 JS 검사도 유지
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