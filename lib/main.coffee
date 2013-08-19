es = require 'event-stream'
cv = require 'opencv'

module.exports =
  createStream: (idx=0) ->
    cam = new cv.VideoCapture idx

    s = es.readable (count, cb) ->
      s.snapshot (err, buf) =>
        if err
          @emit 'error', err
        else
          @emit 'data', buf
        cb()

    s.snapshot = (cb) ->
      cam.read (err, i) ->
        cb err, i.toBuffer()

    s.record = (ms, cb) ->
      vid = []
      push = (buf) -> vid.push buf
      clear = ->
        s.removeListener 'data', push
        cb vid

      setTimeout clear, ms
      s.on 'data', push

    return s