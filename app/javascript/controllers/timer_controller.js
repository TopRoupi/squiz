import ApplicationController from './application_controller'

function startTimer(duration, display) {
    var timer = duration, minutes, seconds;
    setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        if (--timer < 0) {
            timer = 0;
        }
    }, 1000);
}

export default class extends ApplicationController {
  static values = {
    duration: { type: Number, default: 30 },
  }

  connect () {
    super.connect()

    var duration = this.durationValue
    this.element.innerHTML = "00:00"

    startTimer(duration, this.element);
  }
}
