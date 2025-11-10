document.addEventListener("turbo:load", () => {
    const logoutButton = document.getElementById("logout-button");
    const modalElement = document.getElementById("logoutModal");

    if (!logoutButton || !modalElement) return;

    const logoutModal = new bootstrap.Modal(modalElement);

    logoutButton.replaceWith(logoutButton.cloneNode(true));
    const newLogoutButton = document.getElementById("logout-button");

    newLogoutButton.addEventListener("click", (e) => {
        e.preventDefault();
        logoutModal.show();
    });
});
