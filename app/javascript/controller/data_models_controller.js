import { Controller } from 'stimulus'

export default class extends Controller {
  static values = {
    dataModelId: String,
    slug: String
  }

  show(event) {
    // skip if  element is an anchor. It should proceed to anchor's href
    if (event.target.nodeName != 'A') {
      window.location.href = "/offices/" + this.slugValue +"/data_models/" + this.dataModelIdValue
    }
  }
}
