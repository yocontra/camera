const camera = require('../')
const should = require('should')
require('mocha')

const Stream = require('stream')

describe('camera', function() {
  describe('createStream()', function() {
    it('should return a stream', function(done) {
      if (process.env.CI) return done()
      const cam = camera.createStream()
      should.exist(cam)
      cam.should.be.instanceof(Stream)
      cam.destroy()
      done()
    })

    it('should return data events', function(done) {
      if (process.env.CI) return done()
      const cam = camera.createStream()
      should.exist(cam)
      cam.on('data', function(buf) {
        should.exist(buf)
        cam.destroy()
        done()
      })
    })

    it('should pause', function(done) {
      if (process.env.CI) return done()
      const cam = camera.createStream()
      should.exist(cam)
      cam.pause()
      cam.on('data', function() { throw 'fail' })
      const finish = function() {
        cam.destroy()
        done()
      }
      setTimeout(finish, 1000)
    })

    it('should pause then resume', function(done) {
      if (process.env.CI) return done()
      const cam = camera.createStream()
      should.exist(cam)
      cam.pause()
      cam.resume()
      cam.on('data', function() {
        cam.destroy()
        done()
      })
    })
  })

  describe('snapshot()', () => it('should return a buffer', function(done) {
    if (process.env.CI) return done()
    const cam = camera.createStream()
    should.exist(cam)
    cam.snapshot(function(err, buf) {
      should.not.exist(err)
      should.exist(buf)
      cam.destroy()
      done()
    })
  }))

  describe('snapshot()', () => it('should return a buffer', function(done) {
    if (process.env.CI) return done()
    const cam = camera.createStream()
    should.exist(cam)
    cam.record(1000, function(bufs) {
      should.exist(bufs)
      cam.destroy()
      done()
    })
  }))
})