import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["want", "playing", "complete", "wants", "plays", "completes"]

  want() {
    this.wantTarget.classList.add('selected-category')
    this.playingTarget.classList.remove('selected-category')
    this.completeTarget.classList.remove('selected-category')
    this.playsTarget.setAttribute('hidden', 'true')
    this.completesTarget.setAttribute('hidden', 'true')
    this.wantsTarget.removeAttribute('hidden')
  }

  playing() {
    this.playingTarget.classList.add('selected-category')
    this.wantTarget.classList.remove('selected-category')
    this.completeTarget.classList.remove('selected-category')
    this.wantsTarget.setAttribute('hidden', 'true')
    this.completesTarget.setAttribute('hidden', 'true')
    this.playsTarget.removeAttribute('hidden')
  }

  completed() {
    this.completeTarget.classList.add('selected-category')
    this.playingTarget.classList.remove('selected-category')
    this.wantTarget.classList.remove('selected-category')
    this.wantsTarget.setAttribute('hidden', 'true')
    this.playsTarget.setAttribute('hidden', 'true')
    this.completesTarget.removeAttribute('hidden')
  }

  connect() {
    this.wantTarget.classList.add('selected-category')
    this.wantsTarget.removeAttribute('hidden')
  }
}
