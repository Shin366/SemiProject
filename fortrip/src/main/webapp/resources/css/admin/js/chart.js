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