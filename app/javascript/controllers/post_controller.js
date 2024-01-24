import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="post"
export default class extends Controller {
  static targets = ['field', 'output']

  connect() {
    this.change()
  }

  change() {
    let length = this.fieldTarget.value.length

    this.outputTarget.textContent = `${length}`
  }
}
