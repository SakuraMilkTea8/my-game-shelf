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
    // console.log(event.currentTarget.id);
    // destination: event.currentTarget[1].value
    // edit_shelf_game_ event.currentTarget.id
    let cardIdArray = event.currentTarget.id.split('_')
    let cardId = cardIdArray[cardIdArray.length - 1]
    // console.log(cardId);
    let shelfCard = this.shelfcardTargets.find(e => e.id === cardId)
    console.log(shelfCard);
    if (event.currentTarget[1].value === 'want to play') {
      this.wantsRowTarget.insertAdjacentElement("beforeend", shelfCard);
    } else if (event.currentTarget[1].value === 'now playing') {
      this.playsRowTarget.insertAdjacentElement("beforeend", shelfCard);
    } else if (event.currentTarget[1].value === 'completed') {
      this.completesRowTarget.insertAdjacentElement("beforeend", shelfCard);
    }
    // shelfCard.remove()
  }

  connect() {
    this.wantTarget.classList.add('selected-category')
    this.wantsTarget.removeAttribute('hidden')
    // console.log(this.formTargets);
    // console.log(this.shelfcardTargets);
  }
}
