import ApplicationController from './application_controller'

function startTimer(duration, display, callback) {
    var timer = duration, minutes, seconds;
    var interval = setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        if (--timer < 0) {
          callback()
          clearInterval(interval)
        }
    }, 1000);
}

function zeroPad(num, places) {
  return String(num).padStart(places, '0')
}

export default class extends ApplicationController {
  static values = {
    duration: { type: Number, default: 30 },
    callbackReflex: { type: String, default: "" }
  }

  connect () {
    super.connect()

    var duration = this.durationValue
    this.element.innerHTML = `${zeroPad(Math.floor(this.durationValue / 60), 2)}:${(zeroPad(Math.floor(this.durationValue % 60), 2))}`

    console.log(this.callbackReflexValue)
    startTimer(duration, this.element, () => {
      this.stimulate(this.callbackReflexValue)
    });
  }
}
