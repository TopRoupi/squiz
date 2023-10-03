console.log('Vite ⚡️ Rails')

import * as Turbo from '@hotwired/turbo'
Turbo.start()

import * as ActiveStorage from "@rails/activestorage"
ActiveStorage.start()

const channels = import.meta.globEager('./**/*_channel.js')

import "../controllers"

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'
