import ApplicationController from './application_controller'

export default class extends ApplicationController {
  static values = {
    url: { type: String, default: "noaudio" },
  }

  connect () {
    super.connect()

    var volume = localStorage.getItem("volume");
    if(volume == null) {
      localStorage.setItem("volume", 0.5);
    }

    this.element.innerHTML = "<audio class=\"hidden\" id=\"player\" controls><source src=\"" + this.urlValue + "\"></source></audio>"

    // who cares
    this.element.innerHTML += "<input id=\"volume\" class=\"w-full range\" data-action=\"change->auto-play#changeVolume\" type=\"range\" min=\"0\" max=\"100\" />"

    document.getElementById("volume").value = volume * 100

    var audio_element = this.element.children[0]
    this.playAudio(audio_element)

    document.getElementById("player").volume = volume
  }

  changeVolume (element) {
    document.getElementById("player").volume = element.target.value / 100
    localStorage.setItem("volume", element.target.value / 100);
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
