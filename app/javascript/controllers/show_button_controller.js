import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['want', 'play', 'complete', 'content']

  change(event) {
    event.preventDefault()
    this.wantTarget[2].classList.remove('btn-outline-primary')
    this.playTarget[2].classList.remove('btn-outline-primary')
    this.completeTarget[2].classList.remove('btn-outline-primary')
    this.wantTarget[2].classList.add('btn-primary')
    this.playTarget[2].classList.add('btn-primary')
    this.completeTarget[2].classList.add('btn-primary')
    event.currentTarget[2].classList.remove('btn-primary')
    event.currentTarget[2].classList.add('btn-outline-primary')
    event.currentTarget[2].blur()
    if (event.currentTarget[2].value === 'Want to play') {
      this.contentTarget.innerText = "This game is on your shelf under want to play"
    } else if (event.currentTarget[2].value === 'Currently playing') {
      this.contentTarget.innerText = "This game is on your shelf under currently playing"
    } else if (event.currentTarget[2].value === 'Completed') {
      this.contentTarget.innerText = "This game is on your shelf under completed"
    }
  }
}
