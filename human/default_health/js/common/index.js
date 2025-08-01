// 메인 화면 js
const sliderWrap = document.querySelector(".imgSlide");
const imgSlide = document.querySelector(".imgSlide");
const slideInner = document.querySelector(".slideInner");
const slider = document.querySelectorAll(".slider");
const slideBtn = document.querySelector("slideBtn");
const prev = document.querySelector(".prev");
const next = document.querySelector(".next");

let currentIndex = 0;
let sliderCount = slider.length;
let sliderWidth = imgSlide.offsetWidth;

function gotoSlider(num) {
    slideInner.style.transition = "all 400ms";
    slideInner.style.transform = "translateX(" + -sliderWidth * num + "px)";
    currentIndex = num;
}

// 3초마다 슬라이드 전환
setInterval(() => {
    var nextIndex = (currentIndex + 1) % sliderCount;
    gotoSlider(nextIndex);
}, 3000);


prev.addEventListener("click", () => {
    let prevIndex = (sliderCount + currentIndex - 1) % sliderCount;
    gotoSlider(prevIndex);
});

next.addEventListener("click", () => {
    let nextIndex = (currentIndex + 1) % sliderCount;
    gotoSlider(nextIndex);
});

// 프로필사진 확대
function openImageInNewWindow(imageSrc) {
    window.open(imageSrc, '_blank', 'width=800,height=800');
  }
// 메인 화면 js 끝