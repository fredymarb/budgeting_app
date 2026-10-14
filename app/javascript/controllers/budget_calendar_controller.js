import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    basePath: String,
    month: String
  }

  previous() {
    this.navigate(-1)
  }

  next() {
    this.navigate(1)
  }

  navigate(offset) {
    const [year, month] = this.monthValue.split("-").map(Number)
    const target = new Date(year, month - 1 + offset, 1)
    const targetMonth = `${target.getFullYear()}-${String(target.getMonth() + 1).padStart(2, "0")}`

    window.Turbo.visit(`${this.basePathValue}/${targetMonth}`)
  }
}
