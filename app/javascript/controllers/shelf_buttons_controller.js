import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // static targets = ["items", "form"]

  connect() {
    console.log(this.element.id)
  }
}
