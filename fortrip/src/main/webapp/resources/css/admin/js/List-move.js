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