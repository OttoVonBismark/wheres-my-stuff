import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    'hasShippedLabel',
    'hasShippedField',
    'hasDueDateLabel',
    'hasDueDateField',
    'hasArrivedLabel',
    'hasArrivedField'
  ]

  connect() {
    this.hasShippedLabelTarget.classList.add('hidden')
    this.hasShippedFieldTarget.classList.add('hidden')
    this.hasDueDateLabelTarget.classList.add('hidden')
    this.hasDueDateFieldTarget.classList.add('hidden')
    this.hasArrivedLabelTarget.classList.add('hidden')
    this.hasArrivedFieldTarget.classList.add('hidden')
  }

  toggle_shipped() {
    this.hasShippedLabelTarget.classList.toggle('hidden')
    this.hasShippedFieldTarget.classList.toggle('hidden')
  }

  toggle_due() {
    this.hasDueDateLabelTarget.classList.toggle('hidden')
    this.hasDueDateFieldTarget.classList.toggle('hidden')
  }

  toggle_arrived() {
    this.hasArrivedLabelTarget.classList.toggle('hidden')
    this.hasArrivedFieldTarget.classList.toggle('hidden')
  }
}
