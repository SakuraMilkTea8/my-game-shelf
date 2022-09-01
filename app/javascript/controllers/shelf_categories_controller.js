import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["want", "playing", "complete", "wants", "plays", "completes", "form", "shelfcard", "wantsRow", "playsRow", "completesRow"]

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

  updateCategory(event) {
    event.preventDefault();
    let cardIdArray = event.currentTarget.id.split('_')
    let cardId = cardIdArray[cardIdArray.length - 1]
    let shelfCard = this.shelfcardTargets.find(e => e.id === cardId)
    if (event.currentTarget[2].value === 'want to play') {
      this.wantsRowTarget.insertAdjacentElement("beforeend", shelfCard);
    } else if (event.currentTarget[2].value === 'now playing') {
      this.playsRowTarget.insertAdjacentElement("beforeend", shelfCard);
    } else if (event.currentTarget[2].value === 'completed') {
      this.completesRowTarget.insertAdjacentElement("beforeend", shelfCard);
    }
  }

  connect() {
    this.wantTarget.classList.add('selected-category')
    this.wantsTarget.removeAttribute('hidden')
  }
}
