
import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = [
    'fields',
    'addFieldLink'
  ]

  addField(event) {
    let time = new Date().getTime()
    let dataset = this.addFieldLinkTarget.dataset
    let regexp = new RegExp(dataset.id, 'g')
    let div = document.createElement('div')
    div.innerHTML = this.addFieldLinkTarget.dataset.fields.replace(regexp, time)

    // this.fieldsTarget.innerHTML = this.fieldsTarget.innerHTML + this.addFieldLinkTarget.dataset.fields.replace(regexp, time)
    this.fieldsTarget.appendChild(div)
    // $(this).before($(this).data('fields').replace(regexp, time))


    event.preventDefault()
  }
}
