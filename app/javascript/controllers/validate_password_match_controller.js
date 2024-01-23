import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="validate-password-match"
export default class extends Controller {
  static targets = [ 'passwordField', 'confirmationField', 'errorMessage' ]

  validateMatch() {
    if (this.confirmationFieldTarget.value == '') {
      resetStyles()
    } else if (this.confirmationFieldTarget.value !== this.passwordFieldTarget.value) {
      this.confirmationFieldTarget.style = "border-color: rgb(239, 68, 68);"
      this.errorMessageTarget.style = 'display: block;'
    } else {
      this.confirmationFieldTarget.style = "border-color: rgb(34, 197, 94);"
      this.errorMessageTarget.style = 'display: hidden;'
    }
  }

  hideErrorMessage() {
    this.errorMessageTarget.style = 'display: hidden;'
  }

  resetStyles() {
    if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      this.confirmationFieldTarget.style = 'border-color: rgb(75, 85, 99);'
    } else {
      this.confirmationFieldTarget.style = 'border-color: rgb(209, 213, 219);'
    }
  }
}
