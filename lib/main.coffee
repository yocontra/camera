es = require 'event-stream'
cv = require 'opencv'

module.exports =
  createStream: (idx=0) ->
    cam = new cv.VideoCapture idx

    s = es.readable (count, cb) ->
      cam.read (err, i) =>
        if err
          @emit 'error', err
        else
          @emit 'data', i.toBuffer()
        cb()

    s.snapshot = (cb) ->
      s.once 'data', cb

    s.record = (ms, cb) ->
      vid = []
      push = (buf) -> vid.push buf
      clear = ->
        s.removeListener 'data', push
        cb vid

      setTimeout clear, ms
      s.on 'data', push

    return s