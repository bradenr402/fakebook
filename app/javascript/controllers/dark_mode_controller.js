import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dark-mode"
export default class extends Controller {
  static targets = [ "lightIcon", "darkIcon", "themeToggle" ]
  connect() {
    if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      this.lightIconTarget.classList.remove('hidden');
    } else {
      this.darkIconTarget.classList.remove('hidden');
    }
  }

  toggleTheme() {
    console.log('theme target clicked')
    this.lightIconTarget.classList.toggle('hidden');
    this.darkIconTarget.classList.toggle('hidden');
    if (localStorage.getItem('color-theme')) {
      if (localStorage.getItem('color-theme') === 'light') {
        document.documentElement.classList.add('dark');
        localStorage.setItem('color-theme', 'dark');
      } else {
        document.documentElement.classList.remove('dark');
        localStorage.setItem('color-theme', 'light');
      }
    } else {
      if (document.documentElement.classList.contains('dark')) {
        document.documentElement.classList.remove('dark');
        localStorage.setItem('color-theme', 'light');
      } else {
        document.documentElement.classList.add('dark');
        localStorage.setItem('color-theme', 'dark');
      }
    }
  }
}
