const from = require('from2')
const cv = require('opencv4nodejs')

module.exports = {
  createStream: (idx=0) => {
    const cam = new cv.VideoCapture(idx)

    const s = from((count, cb) => {
      s.snapshot(cb)
    })

    s.snapshot = (cb) => {
      cam.readAsync((err, mat) => {
        if (err) return cb(err)
        cb(null, cv.imencode('.png', mat))
      })
    }

    s.record = (ms, cb) => {
      const vid = []
      const push = (buf) => vid.push(buf)
      const clear = () => {
        s.removeListener('data', push)
        cb(vid)
      }

      setTimeout(clear, ms)
      s.on('data', push)
    }

    return s
  }
}