import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static values = {
    url: { type: String, default: "noaudio" },
  }

  connect () {
    super.connect()

    this.element.innerHTML = "<audio controls><source src=\"" + this.urlValue + "\"></audio>"

    var audio_element = this.element.children[0]
    this.playAudio(audio_element)
  }

  playAudio (element) {
    element.play().catch(error => {
      if (error.name === 'NotAllowedError' || error.name === 'NotSupportedError') {
        alert("we wont access your mic to anything this permission is required so we can autoplay audio")
        navigator.mediaDevices.getUserMedia({
          audio: true,
        }).then(() => {
          element.play()
        })
      }
    })
  }
}
