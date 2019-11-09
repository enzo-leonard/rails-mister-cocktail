
const initUpdateNavbarOnScroll = () => {
  window.addEventListener("DOMContentLoaded", (event) => {
    const navbar = document.querySelector('.navbar-lewagon');

  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= window.innerHeight*0.55) {
        navbar.classList.add('navbar-lewagon-white');
      } else {
        navbar.classList.remove('navbar-lewagon-white');
      }
    });
  }


 });
}

export {
  initUpdateNavbarOnScroll
};
