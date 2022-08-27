import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static target = "form"

  connect() {
    console.log(this.element.id)
    console.log(this.formTarget);
  }
}
