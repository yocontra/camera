camera = require '../'
should = require 'should'
require 'mocha'

Stream = require 'stream'

describe 'camera', ->
  describe 'createStream()', ->
    it 'should return a stream', (done) ->
      return done() if process.env.CI
      cam = camera.createStream()
      should.exist cam
      cam.should.be.instanceof Stream
      cam.destroy()
      done()

    it 'should return data events', (done) ->
      return done() if process.env.CI
      cam = camera.createStream()
      should.exist cam
      cam.on 'data', (buf) ->
        should.exist buf
        cam.destroy()
        done()

    it 'should pause', (done) ->
      return done() if process.env.CI
      cam = camera.createStream()
      should.exist cam
      cam.pause()
      cam.on 'data', -> throw 'fail'
      finish = ->
        cam.destroy()
        done()
      setTimeout finish, 1000

    it 'should pause then resume', (done) ->
      return done() if process.env.CI
      cam = camera.createStream()
      should.exist cam
      cam.pause()
      cam.resume()
      cam.on 'data', ->
        cam.destroy()
        done()

  describe 'snapshot()', ->
    it 'should return a buffer', (done) ->
      return done() if process.env.CI
      cam = camera.createStream()
      should.exist cam
      cam.snapshot (err, buf) ->
        should.not.exist err
        should.exist buf
        cam.destroy()
        done()

  describe 'snapshot()', ->
    it 'should return a buffer', (done) ->
      return done() if process.env.CI
      cam = camera.createStream()
      should.exist cam
      cam.record 1000, (bufs) ->
        should.exist bufs
        cam.destroy()
        done()