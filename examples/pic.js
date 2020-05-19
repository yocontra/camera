const fs = require('fs')
const camera = require('../')

const webcam = camera.createStream(1)

webcam.on('error', (err) => {
  console.log('error reading data', err)
})

webcam.once('data', (buffer) => {
  fs.writeFileSync('cam.png', buffer)
  webcam.destroy()
})