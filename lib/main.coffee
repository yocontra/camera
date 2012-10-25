Stream = require 'stream'
cv = require 'opencv'

module.exports =
  snapshot: (s, cb) -> s.on 'data', cb
  createStream: (idx=0) ->
    cam = new cv.VideoCapture idx

    s = new Stream
    s.readable = true
    s.paused = s.destroyed = s.writable = false

    getImage = ->
      cam.read (i) ->
        return if s.paused or s.destroyed
        s.emit 'data', i.toBuffer()
        process.nextTick getImage

    s.pause = -> 
      s.paused = true
      return @
    s.resume = ->
      s.paused = false
      getImage()
      return @
    s.destroy = ->
      s.destroyed = true
      @emit 'close'
      return

    getImage()
    return s