Stream = require 'stream'
cv = require 'opencv'

module.exports =
  snapshot: (s, cb) -> s.once 'data', cb

  record: (s, ms, cb) ->
    vid = []
    push = (buf) -> vid.push buf
    clear = ->
      s.removeListener 'data', push
      cb vid

    setTimeout clear, ms
    s.on 'data', push

  createStream: (idx=0) ->
    cam = new cv.VideoCapture idx

    s = new Stream
    s.readable = true
    s.paused = s.destroyed = s.writable = false

    getImage = ->
      cam.read (i) ->
        return if s.paused or s.destroyed
        return unless s.readable
        s.emit 'data', i.toBuffer()
        process.nextTick getImage

    s.pause = -> 
      s.paused = true
      return s
    s.resume = ->
      s.paused = false
      getImage()
      return s
    s.destroy = ->
      s.destroyed = true
      s.readable = false
      @emit 'close'
      return

    getImage()
    return s