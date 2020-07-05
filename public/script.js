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

const bars = document.querySelectorAll("progress");

const updateBars = (runningCheck = true) => {
  bars.forEach((bar) => {
    const running = bar.getAttribute("running") == "true";
    if (!running && runningCheck) return;
    const total = parseInt(bar.getAttribute("seconds"));
    const span = document.getElementById(`${bar.getAttribute("id")}_remaining`);
    let remaining = parseInt(bar.getAttribute("remaining"));
    remaining = running ? remaining - 1 : remaining;
    bar.setAttribute("remaining", remaining);
    if (parseInt(bar.getAttribute("remaining")) < 1) {
      bar.setAttribute("remaining", 0);
      bar.setAttribute("running", "false");
      bar.setAttribute("value", 0);
      span.innerText = "00:00";
    } else {
      const mins = Math.floor(remaining / 60);
      span.innerText = `${("0" + mins).slice(-2)}:${("0" + (remaining - mins * 60)).slice(-2)}`;
      bar.setAttribute("value", parseInt((remaining * 100) / total));
    }
  });
};

updateBars(false);
window.setInterval(() => updateBars(), 1000);
