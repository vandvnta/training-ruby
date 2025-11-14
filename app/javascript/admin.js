document.addEventListener("turbo:load", () => {
  document.querySelectorAll('.dropdown-toggle').forEach(dropdownToggleEl => {
    if (!bootstrap.Dropdown.getInstance(dropdownToggleEl)) {
      new bootstrap.Dropdown(dropdownToggleEl);
    }
  });

  const logoutButton = document.getElementById("logout-button");
  const logoutModalEl = document.getElementById("logoutModal");

  if (logoutButton && logoutModalEl) {
    const logoutModal = new bootstrap.Modal(logoutModalEl);

    logoutButton.replaceWith(logoutButton.cloneNode(true));
    const newLogoutButton = document.getElementById("logout-button");

    newLogoutButton.addEventListener("click", (e) => {
      e.preventDefault();
      logoutModal.show();
    });
  }
});
