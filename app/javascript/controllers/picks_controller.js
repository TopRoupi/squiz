import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static values = {
    disabled: { type: Boolean, default: false },
    picked: { type: String },
    result: { type: String },
  }

  static targets = [ "choice" ]

  connect () {
    console.log(this.disabledValue)
    console.log(this.choiceTargets)
  }

  disabledValueChanged() {
    for (let i in this.choiceTargets) {
      let element = this.choiceTargets[i]
      if (this.disabledValue == true) {
        element.setAttribute("disabled", "disabled")
      } else {
        element.removeAttribute("disabled")
      }
    }
  }

  pickedValueChanged() {
    for (let i in this.choiceTargets) {
      let element = this.choiceTargets[i]
      if(element.id == this.pickedValue) {
        element.classList.add("picked")
      } else {
        element.classList.remove("picked")
      }
    }
  }

  resultValueChanged() {
    for (let i in this.choiceTargets) {
      let element = this.choiceTargets[i]

      if(element.id == this.pickedValue && element.id != this.resultValue) {
        element.classList.add("wrong-pick")
      }
      if(element.id == this.resultValue) {
        element.classList.add("pick-result")
      }
      if(element.id != this.pickedValue && element.id != this.resultValue && this.resultValue != "") {
        element.classList.add("not-picked")
      }
    }
  }
}
