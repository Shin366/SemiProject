<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ForTrip - 회원가입 이용약관</title>
<link rel="icon" type="image/png" href="../../../resources/img/common/eyes-icon.png">

<link rel="stylesheet" href="../../../resources/css/member/use.css"> 

</head>
<body>
	<div id="container">
        <main id="main">
        <form action="/member/signup" method="get" id="agreementForm"> 
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
                    <label for="use-all">전체 동의</label>
                </div>
                <hr style="border: 0; border-top: 1px dashed #ccc; margin: 10px 0;">
                <ul class="useTerms">
                    <div class="form-group">
                        <input type="checkbox" id="use1" name="use1" class="use-checkbox" data-url="/member/use1">
                        <label class="required" for="use1"><a href="javascript:void(0)" onclick="openPopup('/member/use1', '이용약관')"> for trip 이용약관</a> 동의</label>
                    </div>
                    <div class="form-group">
                        <input type="checkbox" id="use2" name="use2" class="use-checkbox" data-url="/member/use2">
                        <label class="required" for="use2"><a href="javascript:void(0)" onclick="openPopup('/member/use2', '개인정보 수집')"> 개인정보 수집 및 이용</a>에 대한 동의</label>
                    </div>
                    <div class="form-group">
                        <input type="checkbox" id="use3" name="use3" class="use-checkbox" data-url="/member/use3">
                        <label class="required" for="use3"><a href="javascript:void(0)" onclick="openPopup('/member/use3', '제3자 제공')"> 개인정보 제3자 제공</a>에 대한 동의</label>
                    </div>
                </ul>
            </div>
            <button type="submit" class="use-button" id="nextButton" disabled>다음</button>
        </form>
        </main>
    </div>
    
    <script>
        const useAllCheckbox = document.getElementById('use-all');
        const useCheckboxes = document.querySelectorAll('.use-checkbox');
        const form = document.getElementById('agreementForm');
        const nextButton = document.getElementById('nextButton');
        
        // 버튼 상태 업데이트 함수
        function updateButtonState() {
            const allChecked = Array.from(useCheckboxes).every(cb => cb.checked);
            
            if (allChecked) {
                nextButton.classList.add('active');
                nextButton.disabled = false;
            } else {
                nextButton.classList.remove('active');
                nextButton.disabled = true;
            }
        }

        // 초기 버튼 상태 설정
        updateButtonState(); 
        
        // 전체 동의 클릭 이벤트
        useAllCheckbox.addEventListener('change', () => {
            useCheckboxes.forEach(cb => cb.checked = useAllCheckbox.checked);
            updateButtonState();
        });
        
        // 개별 체크박스 클릭 이벤트
        useCheckboxes.forEach(cb => {
            cb.addEventListener('change', () => {
                useAllCheckbox.checked = Array.from(useCheckboxes).every(c => c.checked);
                updateButtonState();
            });
        });
        
        // 폼 제출 시 최종 확인
        form.addEventListener('submit', (e) => {
            if (nextButton.disabled) {
                e.preventDefault(); 
                alert('모든 필수 약관에 동의해야 다음 단계로 진행할 수 있습니다.');
            }
        });

        // ✅ 팝업 창 띄우는 함수 (수정됨)
        function openPopup(url, title) {
            // 팝업 창 크기 설정
            const width = 800;
            const height = 600;
            
            // 화면 중앙 위치 계산
            const left = (window.screen.width / 2) - (width / 2);
            const top = (window.screen.height / 2) - (height / 2);
            
            // ✅ 팝업 옵션 문자열 (공백 없이)
            const options = 'width=' + width + 
                            ',height=' + height + 
                            ',left=' + left + 
                            ',top=' + top + 
                            ',scrollbars=yes' +
                            ',resizable=yes' +
                            ',toolbar=no' +
                            ',menubar=no' +
                            ',location=no' +
                            ',status=no';
            
            // 팝업 열기
            window.open(url, title, options);
        }
    </script>
</body>
</html>