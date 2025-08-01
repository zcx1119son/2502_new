<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>FullCalendar 일정표</title>

  <!-- FullCalendar CSS & JS -->
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/main.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.3/locales/ko.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <style>
    body {
      font-family: 'Apple SD Gothic Neo', sans-serif;
      background-color: #f7f7fb;
      margin: 0;
      padding: 65px;
    }

    .calendar-container {
      width: 66.6%;
      margin: 100px auto;
      position: relative;
      padding-bottom: 40px;
    }

    .fc {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.05);
      padding: 10px;
    }

    .fc-toolbar-title {
      font-size: 12px;
    }

   /* 공통 버튼 스타일 */
   .fc-button {
     background-color: #000000 !important;
     color: #f0f0f0 !important;                /* 밝은 텍스트 */
     border: 1px solid #555 !important;
     border-radius: 8px;
     padding: 4px 8px;
     font-size: 12px;
     font-weight: 500;
     box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* 입체감 있는 음영 */
     transition: all 0.2s ease-in-out;
   }

   /* 호버 시 반응 */
   .fc-button:hover,
   .fc-button:focus {
     background-color: #0039E5 !important;   /* 더 어두운 회색 */
     border-color: #444 !important;
     color: #ffffff !important;
     transform: translateY(-1px);            /* 눌림 반대 효과 */
     box-shadow: 0 4px 8px rgba(0, 0, 0, 0.25);
   }

   /* 활성화된(선택된) 버튼 */
   .fc-button-active {
     background-color: #0039E5 !important;
     border-color: #666 !important;
     color: #ffffff !important;
     box-shadow: inset 0 0 4px rgba(255,255,255,0.2);
   }

   /* 오늘 버튼 별도 스타일 (도시적 감각 유지) */
   .fc-today-button {
     background-color: #4b4b4b !important;
     color: #ffffff !important;
     border-color: #666 !important;
     font-weight: bold;
   }

   .fc-today-button:hover {
     background-color: #333 !important;
     color: #fff !important;
     box-shadow: 0 3px 6px rgba(0,0,0,0.3);
   }

    .fc-timegrid-slot-label {
      font-size: 12px;
    }

    .fc-event {
      font-size: 12px;
      font-weight: bold;
      padding: 2px 4px;
      border: none;
      border-radius: 4px;
    }

    .plan-button {
          position: absolute;
          top: -50px;
          right: 0;
          background-color: #000000;
          color: white;
          padding: 6px 10px;
          font-size: 14px;
          border: none;
          border-radius: 6px;
          cursor: pointer;
        }

        #plan-modal {
          display: none;
          position: fixed;
          top: 20%;
          left: 30%;
          width: 400px;
          background: #ffffff;
          padding: 24px;
          border-radius: 16px;
          box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
          z-index: 1000;
          font-family: 'Arial', sans-serif;
          color: #333;
        }

        #plan-modal h3 {
          margin-top: 0;
          margin-bottom: 16px;
          color: #1e3a8a; /* 진한 파란색 */
          font-size: 20px;
        }

        #plan-modal input[type="text"],
        #plan-modal input[type="datetime-local"],
        #plan-modal textarea {
          width: 100%;
          padding: 10px;
          margin: 6px 0 ;
          border: 0.1px solid #ddd;
          border-radius: 10px;
          font-size: 14px;
          box-sizing: border-box;
        }

        .priority-btn {
          padding: 6px 14px;
          margin-right: 4px;
          margin-top: 4px;
          border: none;
          border-radius: 8px;
          cursor: pointer;
          font-weight: bold;
          font-size: 13px;
          transition: background-color 0.3s ease;
        }

        .priority-btn[data-priority="HIGH"] {
          background-color: #EA0000; /* 빨강 */
          color: white;
        }

        .priority-btn[data-priority="MEDIUM"] {
          background-color: #facc15; /* 노랑 */
          color: black;
        }

        .priority-btn[data-priority="LOW"] {
          background-color: #4ade80; /* 초록 */
          color: white;
        }

        #plan-modal button[type="button"],
        #plan-modal button:not(.priority-btn) {
          padding: 6px 14px;
          margin-top: 4px;
          margin-right: 4px;
          border: none;
          border-radius: 8px;
          background-color: #000000;
          color: white;
          font-size: 13px;
          cursor: pointer;
          transition: background-color 0.3s ease;
        }

        #plan-modal button[type="button"]:hover,
        #plan-modal button:not(.priority-btn):hover {
          background-color: #2563eb; /* 더 진한 파랑 */
        }
  </style>
</head>
<body>

<%@ include file="/WEB-INF/views/include/header.jsp" %>

<div class="calendar-container">
  <button class="plan-button" onclick="openCreateModal()">계획서 작성</button>
  <div id="calendar"></div>
</div>

<!-- 일정 등록/수정 팝업 -->
<div id="plan-modal">
  <h3>일정 수정</h3>
  <input type="hidden" id="event-id">
  <input type="text" id="event-title" placeholder="일정 제목" required><br>
  <input type="text" id="member-name" placeholder="담당자" required><br>
  <input type="text" id="company-name" placeholder="회사명" required><br>
  <textarea id="event-content" placeholder="일정 내용" rows="3"></textarea><br>
  <input type="text" id="client-note" placeholder="비고 (Client Note)" /><br>
  <input type="datetime-local" id="start-date">
  <input type="datetime-local" id="end-date"><br>

  <div>
    <button class="priority-btn" data-priority="HIGH" style="background-color:#f44336; color:white;">높음</button>
    <button class="priority-btn" data-priority="MEDIUM" style="background-color:#ffc107; color:black;">중간</button>
    <button class="priority-btn" data-priority="LOW" style="background-color:#4caf50; color:white;">낮음</button>
  </div><br>

  <button id="submit-btn" type="button" onclick="submitPlan()">등록</button>
  <button id="update-btn" type="button" onclick="updatePlan()" style="display:none;">수정</button>
  <button id="delete-btn" type="button" onclick="deletePlan()" style="display:none;">삭제</button>
  <button type="button" onclick="$('#plan-modal').hide()">닫기</button>
</div>

<script>
// 모달 관련 상태
let selectedPriority = null;

// 우선순위 버튼 클릭 처리
$('.priority-btn').click(function () {
  selectedPriority = $(this).data('priority');
  $('.priority-btn').css('opacity', 0.5);
  $(this).css('opacity', 1);
});

// 폼 초기화
function clearModalForm() {
  $('#event-id').val('');
  $('#event-title').val('');
  $('#member-name').val('');
  $('#company-name').val('');
  $('#event-content').val('');
  $('#client-note').val('');
  $('#start-date').val('');
  $('#end-date').val('');
  selectedPriority = null;
  $('.priority-btn').css('opacity', 0.5);
}

// 폼에서 데이터 추출
function getFormData() {
  return {
    eventId: $('#event-id').val(),
    eventTitle: $('#event-title').val(),
    eventContent: $('#event-content').val(),
    memberName: $('#member-name').val(),
    companyName: $('#company-name').val(),
    clientNote: $('#client-note').val(),
    eventStartDate: $('#start-date').val(),
    eventEndDate: $('#end-date').val(),
    priority: selectedPriority,
    productId: 0,
    productName: '기본상품'
  };
}

// 등록
function submitPlan() {
  const data = getFormData();
  $.ajax({
    url: '/home/insert',
    method: 'POST',
    contentType: 'application/json',
    data: JSON.stringify(data),
    success: function (res) {
      if (res === 'success') {
        alert('등록되었습니다.');
        location.reload();
      } else {
        alert('등록 실패');
      }
    },
    error: function () {
      alert('서버 오류');
    }
  });
}

// 수정
function updatePlan() {
  const data = getFormData();
  $.ajax({
    url: '/home/update',
    method: 'POST',
    contentType: 'application/json',
    data: JSON.stringify(data),
    success: function (res) {
      if (res === 'success') {
        alert('수정되었습니다.');
        location.reload();
      } else {
        alert('수정 실패');
      }
    },
    error: function () {
      alert('서버 오류');
    }
  });
}

// 삭제
function deletePlan() {
  const id = $('#event-id').val();
  if (!id) return alert('이벤트 ID가 없습니다.');
  if (confirm('정말 삭제하시겠습니까?')) {
    $.ajax({
      url: '/home/delete',
      method: 'POST', // POST로 전송
      contentType: 'application/json',
      data: JSON.stringify({ eventId: Number(id) }), // JSON body에 담아 전송
      success: function (res) {
        if (res === 'success') {
          alert('삭제되었습니다.');
          location.reload();
        } else {
          alert('삭제 실패');
        }
      },
      error: function () {
        alert('서버 오류');
      }
    });
  }
}

// 모달 오픈 함수 (HTML에서 onclick 사용 중)
function openCreateModal() {
  clearModalForm();
  $('#submit-btn').show();
  $('#update-btn, #delete-btn').hide();
  $('#plan-modal').show();
}

// 캘린더 초기화
$(document).ready(function () {
  const calendarEl = document.getElementById('calendar');
  const calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    locale: 'ko',
    headerToolbar: {
      left: 'prev,next today',
      center: 'title',
      right: 'dayGridMonth,timeGridWeek'
    },
    slotMinTime: "08:00:00",  // ← 오전 8시부터
    slotMaxTime: "20:00:00",  // ← 오후 8시까지만 보이게
    allDaySlot: false,   // 이 줄을 추가해서 종일 칸 제거
    events: '/home/events',
    eventClick: function (info) {
      const event = info.event;
      $('#event-id').val(event.id || '');
      $('#event-title').val(event.title || '');
      $('#start-date').val(event.startStr.substring(0, 16));
      $('#end-date').val(event.endStr.substring(0, 16));
      $('#event-content').val(event.extendedProps.eventContent || '');
      $('#member-name').val(event.extendedProps.memberName || '');
      $('#company-name').val(event.extendedProps.companyName || '');
      $('#client-note').val(event.extendedProps.clientNote || '');
      selectedPriority = event.extendedProps.priority || null;
      $('.priority-btn').css('opacity', 0.5);
      if (selectedPriority) {
        $(`.priority-btn[data-priority="${selectedPriority}"]`).css('opacity', 1);
      }
      $('#submit-btn').hide();
      $('#update-btn, #delete-btn').show();
      $('#plan-modal').show();
    }
  });

  calendar.render();

});
</script>

<%@ include file="/WEB-INF/views/include/footer.jsp" %>
</body>
</html>