import * as bootstrap from "bootstrap"

document.addEventListener("turbo:load", () => {
    // Initialize all dropdowns
    document.querySelectorAll('.dropdown-toggle').forEach((el) => {
        bootstrap.Dropdown.getOrCreateInstance(el)
    })

    // Initialize modals (logout modal)
    document.querySelectorAll('.modal').forEach((el) => {
        bootstrap.Modal.getOrCreateInstance(el)
    })
})
