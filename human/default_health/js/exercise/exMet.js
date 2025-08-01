const exerciseData = {
    chest: [
        "벤치프레스", "덤벨 벤치 프레스", "덤벨 풀오버", "덤벨 플라이", "푸쉬업",
        "케이블 크로스오버", "딥스", "체스트 플레스 머신", "스미스 머신 벤치 프레스",
        "인클라인 벤치프레스", "덤벨 인클라인 벤치프레스", "디클라인 벤치프레스",
        "케이블 플라이", "덤벨 체스트 플라이", "체스트 딥스", "머신 체스트 프레스",
        "펙덱 머신", "케이블 크로스오버", "트라이셉 딥스", "덤벨 푸쉬업", "체스트 스트레칭"
    ],
    back: [
        "데드리프트", "바벨 로우", "풀 업", "루마니안 데드리프트", "랫 풀다운", 
        "백 익스텐션", "시티드 케이블 로우", "시티드 로우 머신", "덤벨 데드리프트"
    ],
    shoulder: [
        "오버헤드 프레스", "덤벨 숄더 프레스", "덤벨 레터럴 레이즈", "숄더 프레스 머신", 
        "레터럴 레이즈 머신", "시티드 오버헤드 프레스", "덤벨 프론트 레이즈", 
        "페이스 풀", "리버스 케이블 플라이"
    ],
    under: [
        "바벨 스쿼트", "런지", "레그 프레스", "레그 컬", "바벨 스티프 레그 데드리프트",
        "브이 스쿼트", "레그 익스텐션", "덤벨 런지", "핵 스쿼트 머신"
    ],
    abs: [
        "레그 레이즈", "크런치", "케이블 크런치", "캡틴스 체어 레그 레이즈", "행잉 레그 레이즈", 
        "바이시클 크런치", "디클라인 크런치", "덤벨 사이드 밴드", "플랭크"
    ]
};

const pageSize = 20;
const state = {
    chest: 1, 
    back: 1, 
    shoulder: 1, 
    under: 1, 
    abs: 1
};

function renderExercisePage(category) {
    const list = exerciseData[category];
    const page = state[category];
    const start = (page - 1) * pageSize;
    const end = start + pageSize;
    const sliced = list.slice(start, end);

    const tbody = document.getElementById(`${category}TableBody`);
    tbody.innerHTML = sliced.map(name => `<tr><td>${name}</td></tr>`).join("");

    renderExercisePaging(category);
}

function renderExercisePaging(category) {
    const totalPages = Math.ceil(exerciseData[category].length / pageSize);
    const pagesContainer = document.getElementById(`${category}Pages`);
    pagesContainer.innerHTML = "";

    if (totalPages <= 1) {
        document.getElementById(`${category}Paging`).style.display = "none";
        return;
    } else {
        document.getElementById(`${category}Paging`).style.display = "flex";
    }

    for (let i = 1; i <= totalPages; i++) {
        const span = document.createElement("span");
        span.textContent = i;
        if (i === state[category]) span.classList.add("active");
        span.onclick = () => {
            state[category] = i;
            renderExercisePage(category);
        };
        pagesContainer.appendChild(span);
    }

    if (totalPages > 5) {
        const more = document.createElement("span");
        more.textContent = "...(더보기)";
        pagesContainer.appendChild(more);
    }
}

function goFirst(category) {
    state[category] = 1;
    renderExercisePage(category);
}

function goPrev(category) {
    if (state[category] > 1) {
        state[category]--;
        renderExercisePage(category);
    }
}

function goNext(category) {
    const total = Math.ceil(exerciseData[category].length / pageSize);
    if (state[category] < total) {
        state[category]++;
        renderExercisePage(category);
    }
}

function goLast(category) {
    state[category] = Math.ceil(exerciseData[category].length / pageSize);
    renderExercisePage(category);
}

// 초기화 및 페이지 렌더링
renderExercisePage("chest");
renderExercisePage("back");
renderExercisePage("shoulder");
renderExercisePage("under");
renderExercisePage("abs");