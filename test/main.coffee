camera = require '../'
should = require 'should'
require 'mocha'

Stream = require 'stream'

describe 'camera', ->
  describe 'createStream()', ->
    it 'should return a stream', (done) ->
      cam = camera.createStream()
      should.exist cam
      cam.should.be.instanceof Stream
      cam.destroy()
      done()

    it 'should return data events', (done) ->
      cam = camera.createStream()
      should.exist cam
      cam.on 'data', (buf) ->
        should.exist buf
        cam.destroy()
        done()

    it 'should pause', (done) ->
      cam = camera.createStream()
      should.exist cam
      cam.pause()
      cam.on 'data', -> throw 'fail'
      finish = ->
        cam.destroy()
        done()
      setTimeout finish, 1000

    it 'should pause then resume', (done) ->
      cam = camera.createStream()
      should.exist cam
      cam.pause()
      cam.resume()
      cam.on 'data', ->
        cam.destroy()
        done()