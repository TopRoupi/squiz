import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static values = {
    url: { type: String, default: "noaudio" },
  }

  connect () {
    super.connect()

    console.log("hi")
    console.log(this.urlValue)
    this.element.innerHTML = "<audio controls><source src=\"" + this.urlValue + "\"></audio>"

    var audio_element = this.element.children[0]
    audio_element.play()
    console.log(audio_element)
  }
}
