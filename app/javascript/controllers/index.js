import { application } from "./application"
import StimulusReflex from "stimulus_reflex"
import consumer from "../channels/consumer"
import controller from "./application_controller"
import CableReady from "cable_ready"
import debounced from  "debounced"

debounced.initialize()

import Hello from "./hello_controller"
application.register("hello", Hello)

application.consumer = consumer

StimulusReflex.initialize(application, { controller, isolate: true })
StimulusReflex.debug = true
CableReady.initialize({ consumer })
