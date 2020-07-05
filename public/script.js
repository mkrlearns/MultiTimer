const sidebar = document.querySelector(".sidebar");
const sidebarBG = document.querySelector(".sidebar-background");
const controls = document.querySelectorAll(".control");
const list = document.querySelector(".timer-list");
const menu = document.querySelector(".menu");
const options = document.querySelector(".options");
const content = document.querySelector(".content");
let menu_lock = false;

const togglePopup = (elem, id = false) => {
  const popup = document.querySelector(elem);
  popup.style.display = popup.style.display == "none" ? "" : "none";
  if (id) {
    const form = popup.querySelector("form");
    const action = form.getAttribute("action");
    form.setAttribute("action", action.replace("id", id));
  }
}

const sidebarMargin = () => {
  list.style.marginLeft = sidebar.classList.contains("sidebar-collapsed") ? "50px" : "115px";
}

const sidebarToggle = (toggle = true) => {
  if (toggle) {
    sidebar.classList.toggle("sidebar-collapsed");
    sidebarBG.classList.toggle("sidebar-collapsed");
    sidebarMargin();
  }
  for (const control of controls) {
    control.style.opacity = sidebar.classList.contains("sidebar-collapsed")
      ? "0"
      : "1";
  }
}

["mouseenter", "mouseleave"].forEach((e) =>
  sidebar.addEventListener(e, () => {
    if (menu_lock) return;
    if (e == "mouseenter") {
      sidebar.classList.remove("sidebar-collapsed");
      sidebarBG.classList.remove("sidebar-collapsed");
    } else {
      sidebar.classList.add("sidebar-collapsed");
      sidebarBG.classList.add("sidebar-collapsed");
    }
    sidebarToggle(false);
    sidebarMargin();
  })
);

const menuToggle = () => {
  sidebarToggle();
  menu_lock = !menu_lock;
}
