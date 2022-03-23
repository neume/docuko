import { Controller } from 'stimulus'

export default class extends Controller {
  static values = {
    suggestSlug: { type: Boolean, default: true },
    delimiter: { type: String, default: '-' }
  }

  static targets = [
    'name',
    'slug'
  ]

  updateSlug(event) {
    if(this.suggestSlugValue) {
      let value = this.nameTarget.value
      value = value.trim().toLowerCase().replace(/[^a-zA-Z0-9 -]/, "").replace(/\s/g, this.delimiterValue);

      this.slugTarget.value = value
    }
  }
}

