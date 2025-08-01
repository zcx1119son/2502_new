//프로필 사진변경
function changePhoto() {
  alert('사진 변경 기능은 추후 제공됩니다.');
}

//프로필 사진삭제
function deletePhoto() {
  alert('프로필 사진이 삭제되었습니다.');
}

// 로그아웃
function logOut() {
  if (confirm("로그아웃 하시겠습니까?")) {
    alert("로그아웃 하였습니다.");
    location.href = "../index.html";
  }
}

// 탈퇴
function confirmLeave() {
  if (confirm('정말 탈퇴하시겠습니까?')) {
    alert('회원 탈퇴가 완료되었습니다.');
    location.href = "../index.html";
  }
}

// 칼로리 계산
function showCalories() {
  const muscle = document.getElementById('muscle-exercise').value;
  const aerobic = document.getElementById('aerobic-exercise').value;
  const time = document.getElementById('time').value;
  const goal = document.getElementById('goal').value;

  // 근력운동, 유산소 운동 둘 다 선택 안 했을 때
  const isMuscleSelected = muscle && muscle !== "운동선택";
  const isAerobicSelected = aerobic && aerobic !== "운동선택";

  if (!isMuscleSelected && !isAerobicSelected) {
    alert("근력운동 또는 유산소 운동 중 하나 이상 선택해주세요!");
    return;
  }


  if (!time || !goal) {
    alert("운동 시간과 목표 칼로리를 모두 입력해주세요!");
    return;
  }

  const consumed = Math.min(time * 5, goal); // 예: 1분당 5kcal 소모
  const percentage = (consumed / goal) * 100;

  drawCircle(percentage);

  // 결과 표시
  const resultText = `소모 칼로리: ${consumed.toFixed(1)} kcal`;
  document.getElementById('calorie-result').innerText = resultText;
}

// 일일 목표 활동량 원형차트 
function drawCircle(percent) {
  const canvas = document.getElementById('progressCanvas');
  const ctx = canvas.getContext('2d');
  const radius = canvas.width / 2 - 10;

  ctx.clearRect(0, 0, canvas.width, canvas.height);

  // 배경 원
  ctx.beginPath();
  ctx.arc(canvas.width / 2, canvas.height / 2, radius, 0, 2 * Math.PI);
  ctx.strokeStyle = '#eee';
  ctx.lineWidth = 15;
  ctx.stroke();

  // 진행 원
  ctx.beginPath();
  ctx.arc(canvas.width / 2, canvas.height / 2, radius, -0.5 * Math.PI, (2 * Math.PI) * (percent / 100) - 0.5 * Math.PI);
  ctx.strokeStyle = '#ff7c00';
  ctx.lineWidth = 15;
  ctx.stroke();

  // 텍스트
  ctx.fillStyle = '#333';
  ctx.font = "16px Arial";
  ctx.textAlign = "center";
  ctx.textBaseline = "middle";
  ctx.fillText(`${Math.round(percent)}%`, canvas.width / 2, canvas.height / 2);
}

// 건강 정보 질병 발병률
const ctx = document.getElementById('chart').getContext('2d');
new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ['당뇨', '고혈압', '천식'],
    datasets: [
      {
        label: '운동 시 발병률 (%)',
        data: [7, 10, 5],
        backgroundColor: 'rgba(54, 162, 235, 0.6)'
      },
      {
        label: '비운동 시 발병률 (%)',
        data: [15, 20, 12],
        backgroundColor: 'rgba(255, 99, 132, 0.6)'
      }
    ]
  },
  options: {
    responsive: true,
    plugins: {
      title: {
        display: true,
        text: '운동 여부에 따른 질환 발병률 비교'
      }
    },
    scales: {
      y: {
        beginAtZero: true,
        title: {
          display: true,
          text: '발병률 (%)'
        }
      },
      x: {
        title: {
          display: true,
          text: '질환 종류'
        }
      }
    }
  }
});

// 마이페이지에서 이동
function goMain() {

  location.href = "../index.html";

}

function goLogin() {

  location.href = "../user/login.html?login";

}

// 마이페이지에서 메인화면으로
function goMainUser() {

  location.href = "../index_user.html";

}

// 마이페이지로
function goMypage() {
  location.href = "../user/myPage.html";
}

// 운동법 페이지로
function goEx() {
  location.href = "../exercise/exMet.html";
}

// 운동장비 페이지로
function goEq() {
  location.href = "../healthcare/equipments.html";
}

// 보조식품 페이지로
function goSup() {
  location.href = "../healthcare/supplements.html";
}

// 게시판 페이지로
function goBoard() {
  location.href = "../board/board.html";
}

// 프로필사진 확대
function openImageInNewWindow(imageSrc) {
  window.open(imageSrc, '_blank', 'width=800,height=800');
}