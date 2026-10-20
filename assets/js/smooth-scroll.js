// assets/js/smooth-scroll.js
export function setupSmoothScrolling() {
  // Check if we're in the browser
  if (typeof document === 'undefined') return;

  const navbarHeight = document.querySelector('nav')?.offsetHeight || 80;
  const scrollOffset = navbarHeight + 20; // Additional 20px padding

  document.querySelectorAll('a[href^="#"]:not([data-smooth-scroll-bound])').forEach(anchor => {
    anchor.dataset.smoothScrollBound = 'true';

    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const targetId = this.getAttribute('href');

      if (targetId === '#') return;

      const targetElement = document.querySelector(targetId);
      if (!targetElement) return;

      const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - scrollOffset;

      window.scrollTo({
        top: targetPosition,
        behavior: 'smooth'
      });

      // Update URL
      history.pushState(null, '', targetId);
    });
  });
}
