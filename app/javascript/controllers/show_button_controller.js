import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['want', 'play', 'complete']

  change(event) {
    event.preventDefault()
    this.wantTarget[2].classList.remove('btn-outline-primary')
    this.playTarget[2].classList.remove('btn-outline-primary')
    this.completeTarget[2].classList.remove('btn-outline-primary')
    this.wantTarget[2].classList.add('btn-primary')
    this.playTarget[2].classList.add('btn-primary')
    this.completeTarget[2].classList.add('btn-primary')
    // console.log(event.currentTarget[2]);
    event.currentTarget[2].classList.remove('btn-primary')
    event.currentTarget[2].classList.add('btn-outline-primary')
    event.currentTarget[2].blur()
  }

  play() {

  }

  complete() {

  }

  connect() {
    console.log(this.wantTarget[2]);
    console.log(this.playTarget[2]);
    console.log(this.completeTarget[2]);
  }
}
