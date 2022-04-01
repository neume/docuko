import { Controller } from 'stimulus'
import randomColor from 'randomcolor'

export default class extends Controller {
  static targets = [
    'thumbnailColor'
  ]

  connect(event) {
    let value = this.thumbnailColorTarget.value
    if(!value) {
      this.thumbnailColorTarget.value = randomColor()
    }
  }
}

