import { application } from "./application"
import StimulusReflex from "stimulus_reflex"
import consumer from "../channels/consumer"
import controller from "./application_controller"
import CableReady from "cable_ready"
import debounced from  "debounced"

debounced.initialize()

import Hello from "./hello_controller"
import CableFrom from "./cable_from_controller"
import Timer from "./timer_controller"
import AutoPlay from "./auto_play_controller"
import Picks from "./picks_controller"
application.register("hello", Hello)
application.register("cable-from", CableFrom)
application.register("timer", Timer)
application.register("auto-play", AutoPlay)
application.register("picks", Picks)

application.consumer = consumer

StimulusReflex.initialize(application, { controller, isolate: true })
StimulusReflex.debug = true
CableReady.initialize({ consumer })
