import { Controller } from 'stimulus'

export default class extends Controller {
  static values = {
    instanceId: String,
    slug: String
  }

  // show(event) {
  //   if (event.target.nodeName != 'I') {
  //     window.location.href = "/offices/" + this.slugValue +"/instances/" + this.instanceIdValue;
  //   }
  // }
}
