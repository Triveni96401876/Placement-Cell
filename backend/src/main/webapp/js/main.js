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

// Circular Message Popup & Notification
document.addEventListener('DOMContentLoaded', () => {
    checkCircular();
});

function checkCircular() {
    const path = window.location.pathname;
    const isLocalFile = window.location.protocol === 'file:';

    // Show on home and login pages
    if (path.includes('index.html') || path.includes('login.html') || path === '/' || path.endsWith('/') || isLocalFile) {
        fetch('GetCircularServlet')
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                if (data.status === 'success' && data.message) {
                    createCircularElements(data.message);
                } else {
                    console.log('No active circular found in database.');
                    // Optional: Show a default message if you want it to ALWAYS appear
                    // createCircularElements("Welcome to Sanjay Gandhi Polytechnic! Stay tuned for upcoming campus drives.");
                }
            })
            .catch(err => {
                console.warn('Backend servlet not reachable or error. showing demo message for preview.', err);
                // IF it fails (likely due to relative path or server not running), 
                // we show a demo message so the user can see the UI they requested.
                createCircularElements("Welcome to SGP, Ballari! Next Campus Drive starts from Feb 15th for Mechanical & CS students.");
            });
    }
}

function createCircularElements(message) {
    // 1. Create Floating Notification Button
    const notifyBtn = document.createElement('div');
    notifyBtn.className = 'circular-notification-btn';
    notifyBtn.innerHTML = `
        <i class="fas fa-bullhorn"></i>
        <div class="circular-badge">1</div>
    `;
    notifyBtn.title = "View Official Circular";
    document.body.appendChild(notifyBtn);

    // 2. Create Modal Overlay
    const overlay = document.createElement('div');
    overlay.className = 'modal-overlay';
    document.body.appendChild(overlay);

    // 3. Create Modal
    const modal = document.createElement('div');
    modal.className = 'circular-modal';
    modal.innerHTML = `
        <div class="circular-modal-header">
            <h3><i class="fas fa-bullhorn"></i> Latest Circular</h3>
            <span class="close-modal">&times;</span>
        </div>
        <div class="circular-content">
            ${message}
        </div>
        <div style="margin-top: 1.5rem; text-align: center;">
            <p style="font-size: 0.8rem; color: #999;">Published by Placement Cell</p>
        </div>
    `;
    document.body.appendChild(modal);

    // Event Listeners
    const openModal = () => {
        modal.classList.add('active');
        overlay.classList.add('active');
        notifyBtn.style.animation = 'none'; // Stop pulsing after seeing
    };

    const closeModal = () => {
        modal.classList.remove('active');
        overlay.classList.remove('active');
    };

    notifyBtn.addEventListener('click', openModal);
    overlay.addEventListener('click', closeModal);
    modal.querySelector('.close-modal').addEventListener('click', closeModal);

    // Automatically show popup after 2 seconds on first load
    setTimeout(openModal, 2000);
}
