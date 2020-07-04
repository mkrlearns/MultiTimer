const sidebar = document.querySelector(".sidebar");
const sidebarBG = document.querySelector(".sidebar-background");
const texts = document.querySelectorAll(".text");
const list = document.querySelector(".timer-list");
const menu = document.querySelector(".menu");
const options = document.querySelector(".options");
const content = document.querySelector(".content");
let menu_lock = false;

for (const text of texts) text.style.opacity = "0";

function sidebarCheck() {
  if (sidebar.classList.contains("sidebar-collapsed")) {
    list.style.marginLeft = "50px";
  } else {
    list.style.marginLeft = "150px";
  }
}

function sidebarToggle() {
  for (const text of texts) {
    text.style.opacity = !sidebar.classList.contains("sidebar-collapsed")
      ? "0"
      : "1";
  }
  sidebar.classList.toggle("sidebar-collapsed");
  sidebarBG.classList.toggle("sidebar-collapsed");
  sidebarCheck();
}

function linkScroll(obj) {
  if (obj.classList.contains("sidebar")) {
    content.scrollTop = sidebar.scrollTop;
  } else {
    sidebar.scrollTop = content.scrollTop;
  }
}

["mouseenter", "mouseleave"].forEach((e) =>
  sidebar.addEventListener(e, () => {
    if (!menu_lock) sidebarToggle();
  })
);

menu.addEventListener("click", (e) => {
  sidebarToggle();
  menu_lock = !menu_lock;
});
