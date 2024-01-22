import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="validate-password-match"
export default class extends Controller {
  static targets = ["passwordField", "confirmationField", "errorMessage"]

  connect() {
    console.log('connected')
  }

  validateMatch() {
    if (this.confirmationFieldTarget.value == '') {
      resetStyles()
    } else if (this.confirmationFieldTarget.value !== this.passwordFieldTarget.value) {
      this.confirmationFieldTarget.style = "border-color: rgb(239, 68, 68); background-color: rgba(127, 29, 29, 0.25);"
      this.errorMessageTarget.style = 'display: block;'
    } else {
      this.confirmationFieldTarget.style = "border-color: rgb(34, 197, 94); background-color: rgba(20, 83, 45, 0.25);"
      this.errorMessageTarget.style = 'display: hidden;'
    }
  }

  hideErrorMessage() {
    this.errorMessageTarget.style = 'display: hidden;'
  }

  resetStyles() {
    if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      this.confirmationFieldTarget.style = 'background-color: rgba(51, 65, 85, 0.75); border-color: rgba(39, 39, 42, 0.15);'
    } else {
      this.confirmationFieldTarget.style = 'background-color: transparent; border-color: rgba(39, 39, 42, 0.15);'
    }
  }
}
