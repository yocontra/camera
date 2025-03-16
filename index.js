const { Readable } = require('stream')
const cv = require('@u4/opencv4nodejs')

module.exports = {
  createStream: (idx=0) => {
    const cam = new cv.VideoCapture(idx)

    const s = new Readable({
      objectMode: true,
      read() {
        s.snapshot((err, data) => {
          if (err) {
            this.destroy(err)
            return
          }
          this.push(data)
        })
      }
    })

    s.snapshot = (cb) => {
      cam.readAsync((err, mat) => {
        if (err) return cb(err)
        cb(null, cv.imencode('.png', mat))
      })
    }

    s.record = (duration, cb) => {
      const frames = []
      const push = (buf) => frames.push(buf)
      const clear = () => {
        s.removeListener('data', push)
        cb(frames)
      }

      setTimeout(clear, duration)
      s.on('data', push)
    }

    return s
  }
}