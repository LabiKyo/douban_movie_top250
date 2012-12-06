io = require \node.io
mongo = require \mongoose

# node.io jobs
get-movies = require \./get-movies .job

{open-db, close-db, handle-err, tint} = require \./helper

# tasks
task \get:movies, "Get movies' url", ->
  open-db!

  {Counter} = require \./model

  err, counter <- Counter.findByIdAndUpdate 'movie', {last: 0}, {upsert: true, select: \last}
  handle-err err

  err <- io.start get-movies, {}
  handle-err err, success: -> console.log tint 'Success!'

  close-db!
