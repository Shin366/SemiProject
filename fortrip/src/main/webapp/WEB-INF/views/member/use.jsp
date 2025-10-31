<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 회원가입 이용약관</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">
</head>
<body>
	<div id="container">
        <main id="main">
        <form action="/member/signup" method="get">
            <div class="use-container">
                <div class="use-title">
                    <h2>회원가입</h2>
                </div>
                <div class="use-main-title">
                    <h4>약관동의</h4>
                    <p class="user">약관 내용에 동의해주세요.</p>
                </div>
                <div class="form-group">
                    <input type="checkbox" id="use-all" name="use-all">
                    <label class="required" for="use-all">전체 동의</label>
                </div>
                <ul class="useTerms">
                    <div class="form-group">
                        <input type="checkbox" id="use1" name="use1" class="use-checkbox">
                        <label class="required" for="use1">(필수)<a href="/member/use1">for trip 이용약관</a> 동의</label>
                    </div>
                    <div class="form-group">
                        <input type="checkbox" id="use2" name="use2" class="use-checkbox">
                        <label class="required" for="use2">(필수)<a href="/member/use2">개인정보 수집 및 이용</a>에 대한 동의</label>
                    </div>
                    <div class="form-group">
                        <input type="checkbox" id="use3" name="use3" class="use-checkbox">
                        <label class="required" for="use3">(필수)<a href="/member/use3">개인정보 제3자 제공</a>에 대한 동의</label>
                    </div>
                </ul>
            </div>
            <button type="submit" class="use-button">다음</button>
            </form>
        </main>
    </div>
    <script>
    const useAllCheckbox = document.getElementById('use-all');
    const useCheckboxes = document.querySelectorAll('.use-checkbox');
    const form = document.querySelector('form');
    
    // 전체 동의 클릭
    useAllCheckbox.addEventListener('change', () => {
        useCheckboxes.forEach(cb => cb.checked = useAllCheckbox.checked);
    });
    
    // 개별 체크박스 클릭
    useCheckboxes.forEach(cb => {
        cb.addEventListener('change', () => {
            useAllCheckbox.checked = Array.from(useCheckboxes).every(c => c.checked);
        });
    });
    
    // 폼 제출 시 필수 약관 체크 확인
    form.addEventListener('submit', (e) => {
        const allChecked = Array.from(useCheckboxes).every(cb => cb.checked);
        
        if(!allChecked) {
            e.preventDefault(); // 제출 막기
            alert('모든 필수 약관에 동의해주세요.');
        }
    });
</script>
</body>
</html>