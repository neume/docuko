import { Controller } from 'stimulus'
import 'tom-select'
import TomSelect from 'tom-select'

export default class extends Controller {
  static values = {
    officeSlug: String
  }

  connect() {
    let elementID = this.context.scope.element.id

    let select = new TomSelect(`#${elementID}`, {
      valueField: 'id',
      labelField: 'email',
      searchField: 'email',
      load: this._load(this.officeSlugValue),
      render: {
        option: this._render_option(),
        item: this._render_item()
      }
    })
  }

  _load(slug) {
    return (query, callback) => {
      const url = `/offices/${slug}/search_users.json?search=${query}`

      fetch(url)
        .then(response => response.json())
        .then(data => {
          console.log(data)
          callback(data)
        }).catch(() => {
          console.error
          callback()
        })
    }
  }

  _render_option() {
    return function (item, escape) {
      return `<div>
          ${escape(item.email)}
        </div>`
    }
  }

  _render_item() {
    return function(item, escape) {
      return `<div>
          hello ${escape(item.email)}
        </div>`
    }
  }
}
