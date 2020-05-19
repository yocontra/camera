![status](https://secure.travis-ci.org/contra/camera.png?branch=master)

## Information

<table>
<tr> 
<td>Package</td><td>camera</td>
</tr>
<tr>
<td>Description</td>
<td>Just a dead simple package to create readable streams from connected webcams</td>
</tr>
<tr>
<td>Node Version</td>
<td>>=12</td>
</tr>
</table>

## Install

You'll need OpenCV 4 or newer installed before installing.

## Specific for macOS
Install OpenCV using brew
```bash
brew update
brew install opencv@4
brew link --force opencv@4
```

## Usage

#### createStream([idx])

- The object returned from createStream is a full readable Stream - you can pause, resume, destroy, pipe, etc.
- createStream optionally takes a camera number and defaults to 0 for the primary camera.
- Each data event is a full image buffer from the camera.
- Image buffers are PNGs.
- To convert the buffer to a base64 data uri (for the browser) just do `data:image/png;base64,${buffer.toString('base64')}`

```js
const camera = require('camera')

const webcam = camera.createStream()

webcam.on('data', (buffer) => {
  // do something with image buffer
})
```

#### snapshot(cb)

Returns an error and one image buffer to the given callback. Useful if you just want to grab a simple photo.

#### record(milliseconds, cb)

Returns an array of video frames for the time-span specified in milliseconds.


## Examples


#### Take a picture

```js
const fs = require('fs')
const camera = require('camera')

const webcam = camera.createStream()

webcam.on('error', (err) => {
  console.log('error reading data', err)
})

webcam.on('data', (buffer) => {
  fs.writeFileSync('cam.png', buffer)
  webcam.destroy()
})

webcam.snapshot((err, buffer) => {
  
})

webcam.record(1000, (buffers) => {
  
})
```