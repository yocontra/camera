![status](https://secure.travis-ci.org/wearefractal/camera.png?branch=master)

## Information

<table>
<tr> 
<td>Package</td><td>camera</td>
</tr>
<tr>
<td>Description</td>
<td>Create readable streams from connected webcams</td>
</tr>
<tr>
<td>Node Version</td>
<td>>= 0.4</td>
</tr>
</table>

## Discontinued

Use node-opencv's VideoStream

## Dependencies

This library requires that you have OpenCV installed - go to the OpenCV site for instructions.

## Usage

#### createStream([camera idx])

The object returned from createStream is a full readable Stream - you can pause, resume, destroy, pipe, etc.

createStream optionally takes a camera number and defaults to 0 for the main camera

Each data event is a full image buffer from the camera - the framerate is variable on your CPU (should be an option in the future). Image buffers are PNGs. To convert the buffer to a base64 data uri (for the browser) just do ```"data:image/png;base64," + buffer.toString('base64')```

```coffee-script
camera = require 'camera'

webcam = camera.createStream()

webcam.on 'data', (buffer) ->
  # do something with image buffer
```

#### snapshot(callback)

Returns an error and one image buffer to the given callback.

#### record(milliseconds, cb)

Returns an array of video frames for the time-span specified in milliseconds


## Examples


#### Take a picture

```coffee-script
fs = require 'fs'
camera = require 'camera'

webcam = camera.createStream()

webcam.on 'error', (err) ->
  console.log 'error reading data', err

webcam.on 'data', (buffer) ->
  fs.writeFileSync 'cam.png', buffer
  webcam.destroy()

webcam.snapshot (err, buffer) ->

webcam.record 1000, (buffers) ->
  
```

## LICENSE

(MIT License)

Copyright (c) 2012 Fractal <contact@wearefractal.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/wearefractal/camera/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

