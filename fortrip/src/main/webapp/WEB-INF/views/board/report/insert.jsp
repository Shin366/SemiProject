<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고게시판 - 작성</title>
    <style>
        /* 기본 스타일 초기화 및 설정 */
        body {
            font-family: 'Malgun Gothic', sans-serif;
            background-color: #f4f7f6;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* 신고 양식을 감싸는 컨테이너 */
        .report-container {
            max-width: 700px;
            width: 100%;
        }

        /* 카드 형태의 UI */
        .report-card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            padding: 30px 40px;
        }

        /* 카드 헤더 (제목) */
        .card-header h2 {
            margin: 0 0 20px 0;
            font-size: 24px;
            font-weight: 600;
            border-bottom: 1px solid #e0e0e0;
            padding-bottom: 20px;
        }

        /* 각 입력 섹션 */
        .form-section {
            margin-bottom: 30px;
        }
        
        .form-section h3 {
            font-size: 18px;
            margin-bottom: 8px;
        }

        .form-section p.description {
            font-size: 14px;
            color: #666;
            margin-top: 0;
            margin-bottom: 15px;
        }

        /* 라디오 버튼 그룹 */
        .radio-group label {
            display: block;
            margin-bottom: 10px;
            font-size: 16px;
            cursor: pointer;
        }

        .radio-group input[type="radio"] {
            margin-right: 8px;
        }
        
        /* 텍스트 입력 필드 및 텍스트 영역 */
        .form-group {
             margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 500;
            color: #333;
        }

        input[type="text"],
        input[type="password"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box; /* 패딩이 너비를 초과하지 않도록 설정 */
        }
        
        textarea {
            resize: vertical; /* 수직으로만 크기 조절 가능 */
        }

        /* 비밀번호 입력 그룹 (나란히 배치) */
        .password-group {
            display: flex;
            gap: 20px;
        }

        .password-group .form-group {
            flex: 1;
        }

        /* 버튼 그룹 */
        .button-group {
            text-align: right;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
            margin-right: 10px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>

    <div class="report-container">
        <div class="report-card">
            <div class="card-header">
                <h2>🔒 신고합니다</h2>
            </div>

            <%-- 실제 form action 경로는 Controller에 맞게 수정해주세요 --%>
            <form id="reportForm" action="/report/insert" method="post">
                
                <div class="form-section">
                    <h3>신고 사유</h3>
                    <p class="description">아래 항목 중 하나를 선택해주세요.</p>
                    <div class="radio-group">
                        <label><input type="radio" name="reportReason" value="SPAM" required> 소통 홍보 / 도배</label>
                        <label><input type="radio" name="reportReason" value="OBSCENE"> 음란물</label>
                        <label><input type="radio" name="reportReason" value="ILLEGAL"> 불법 정보</label>
                        <label><input type="radio" name="reportReason" value="ABUSE"> 욕설/생명경시/혐오/차별적 표현</label>
                        <label><input type="radio" name="reportReason" value="PRIVACY"> 개인정보 노출</label>
                        <label><input type="radio" name="reportReason" value="INAPPROPRIATE"> 불쾌한 표현</label>
                    </div>
                </div>

                <div class="form-section">
                    <h3>상세 내용</h3>
                    <p class="description">어떤 점이 문제인지 자세히 알려주시면 처리에 도움이 됩니다.</p>
                    <div class="form-group">
                        <label for="postUrl">게시물 주소</label>
                        <input type="text" id="postUrl" name="postUrl" placeholder="신고할 게시물의 주소(URL)를 입력해주세요." required>
                    </div>
                    <div class="form-group">
                        <label for="reportContent">내용 (필수)</label>
                        <textarea id="reportContent" name="reportContent" rows="5" placeholder="상세 신고 내용을 입력해주세요." required></textarea>
                    </div>
                </div>

                <div class="form-section">
                    <h3>열람용 비밀번호 설정</h3>
                    <p class="description">작성하신 신고 내용과 답변을 확인하기 위한 숫자 4자리 비밀번호입니다.</p>
                    <div class="password-group">
                        <div class="form-group">
                             <label for="password">비밀번호</label>
                             <input type="password" id="password" name="password" maxlength="4" placeholder="숫자 4자리" required>
                        </div>
                        <div class="form-group">
                             <label for="passwordConfirm">비밀번호 확인</label>
                             <input type="password" id="passwordConfirm" maxlength="4" placeholder="한 번 더 입력" required>
                        </div>
                    </div>
                </div>
                
                <div class="button-group">
                    <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-primary">제출</button>
                </div>

            </form>
        </div>
    </div>

<script>
    // 폼 제출 시 유효성 검사
    document.getElementById('reportForm').addEventListener('submit', function(event) {
        // 기본 제출 동작을 막음
        event.preventDefault();

        // 입력 값 가져오기
        const password = document.getElementById('password').value;
        const passwordConfirm = document.getElementById('passwordConfirm').value;
        const content = document.getElementById('reportContent').value.trim();
        const reason = document.querySelector('input[name="reportReason"]:checked');
        
        // 1. 신고 사유 선택 여부
        if (!reason) {
            alert('신고 사유를 선택해주세요.');
            return;
        }

        // 2. 내용 입력 여부
        if (content === '') {
            alert('상세 내용을 입력해주세요.');
            document.getElementById('reportContent').focus();
            return;
        }

        // 3. 비밀번호 유효성 검사 (숫자 4자리)
        const passwordRegex = /^\d{4}$/;
        if (!passwordRegex.test(password)) {
            alert('비밀번호는 숫자 4자리로 설정해야 합니다.');
            document.getElementById('password').focus();
            return;
        }

        // 4. 비밀번호 일치 여부
        if (password !== passwordConfirm) {
            alert('비밀번호가 일치하지 않습니다.');
            document.getElementById('passwordConfirm').focus();
            return;
        }

        // 모든 유효성 검사를 통과하면 폼 제출
        console.log('유효성 검사 통과. 폼을 제출합니다.');
        this.submit();
    });
</script>

</body>
</html>