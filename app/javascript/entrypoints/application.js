console.log('Vite ⚡️ Rails')

import * as Turbo from '@hotwired/turbo'
Turbo.start()

import ActiveStorage from '@rails/activestorage'
ActiveStorage.start()

const channels = import.meta.globEager('./**/*_channel.js')

// Example: Import a stylesheet in app/frontend/index.css
// import '~/index.css'
