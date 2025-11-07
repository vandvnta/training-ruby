document.addEventListener("DOMContentLoaded", () => {
    const logoutButton = document.getElementById("logout-button");
    const modal = document.getElementById("logout-modal");
    const close = document.querySelector(".modal .close");
    const cancel = document.getElementById("cancel-logout");

    logoutButton.addEventListener("click", (e) => {
        e.preventDefault();
        modal.style.display = "block";
    });

    close.addEventListener("click", () => {
        modal.style.display = "none";
    });

    cancel.addEventListener("click", () => {
        modal.style.display = "none";
    });

    window.addEventListener("click", (e) => {
        if (e.target == modal) {
            modal.style.display = "none";
        }
    });
});
