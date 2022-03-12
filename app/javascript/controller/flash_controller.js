import { Controller } from 'stimulus'

export default class extends Controller {
  connect(event) {
    let toastElList = [].slice.call(document.querySelectorAll('.toast'))
    toastElList.forEach(function (toastEl) {
      let toasted = new bootstrap.Toast(toastEl)
      toasted.show()
    })
  }
}
