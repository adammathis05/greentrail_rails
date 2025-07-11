document.addEventListener("DOMContentLoaded", () => {
  const toggleBtn = document.getElementById("menu-toggle");
  const menu = document.getElementById("mobile-menu");
  const menuIcon = document.getElementById("menu-icon");
  const closeIcon = document.getElementById("close-icon");

  const toggleMenu = () => {
    const isOpen = menu.classList.contains("max-h-60");

    if (isOpen) {
      menu.classList.remove("max-h-60");
      menu.classList.add("max-h-0");
      menuIcon.classList.remove("hidden");
      closeIcon.classList.add("hidden");
    } else {
      menu.classList.remove("max-h-0");
      menu.classList.add("max-h-60");
      menuIcon.classList.add("hidden");
      closeIcon.classList.remove("hidden");
    }
  };

  toggleBtn?.addEventListener("click", toggleMenu);

  const menuLinks = menu?.querySelectorAll("a") || [];
  menuLinks.forEach(link => {
    link.addEventListener("click", () => {
      if (menu.classList.contains("max-h-60")) {
        toggleMenu();
      }
    });
  });
});