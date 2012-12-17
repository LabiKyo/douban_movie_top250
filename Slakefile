require! {
  io: \node.io
  mongo: \mongoose

  # jobs
  get-movies: \./get-movies .job
  get-review-count: \./get-review-count .job
  # helper
  \./helper .handle-err
  \./helper .open-db
  \./helper .close-db
  \./helper .tint
}

# tasks
task \get:movies, "Get movies' url", ->
  open-db!

  require! \./model .Counter

  err, counter <- Counter.findByIdAndUpdate 'movie', {last: 0}, {upsert: true, select: \last}
  handle-err err

  err <- io.start get-movies, {}
  handle-err err, success: -> console.log tint 'Success!'

  close-db!

task \get:review:count, "Get count of movie's review", ->
  open-db!
  err <- io.start get-review-count, {}
  handle-err err, success: -> console.log tint 'Success!'
  close-db!
