// Sticky Header
window.addEventListener('scroll', function () {
    const header = document.querySelector('header');
    header.classList.toggle('sticky', window.scrollY > 0);
});

// Mobile Hamburger Menu
const hamburger = document.querySelector('.hamburger');
const navMenu = document.querySelector('.nav-menu');

hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    navMenu.classList.toggle('active');
});

// Close menu when link is clicked
document.querySelectorAll('.nav-link').forEach(n => n.addEventListener('click', () => {
    hamburger.classList.remove('active');
    navMenu.classList.remove('active');
}));

// Add 'sticky' class styling in CSS dynamically or rely on position: sticky
// Note: position: sticky in CSS usually handles this without JS, but JS allows for style changes on scroll (like shrinking)
// We kept it simple in CSS, but this JS adds a class if we want to add extra effects (like shadow on scroll only)

// Circular Message Popup & Notification logic removed to satisfy USER requirements.
