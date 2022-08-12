import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["want", "playing", "complete", "wants", "plays", "completes"]

  want() {
    this.wantTarget.backgroundColor = 'black'
    this.playsTarget.setAttribute('hidden', 'true')
    this.completesTarget.setAttribute('hidden', 'true')
    this.wantsTarget.removeAttribute('hidden')
  }

  playing() {
    this.wantsTarget.setAttribute('hidden', 'true')
    this.completesTarget.setAttribute('hidden', 'true')
    this.playsTarget.removeAttribute('hidden')
  }

  completed() {
    this.wantsTarget.setAttribute('hidden', 'true')
    this.playsTarget.setAttribute('hidden', 'true')
    this.completesTarget.removeAttribute('hidden')
  }

  connect() {
    console.log("Hello from our first Stimulus controller")
  }
}
