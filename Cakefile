io = require 'node.io'
mongo = require 'mongoose'

# node.io jobs
get_movies = require('./get_movies').job
get_movie = require('./get_movie').job

{open_db, close_db} = require './helper'

task 'get:movies', "Get movies' url", ->
  open_db()
  {Counter} = require './models'
  Counter.findByIdAndUpdate 'movie', {last: 0}
  , {upsert: true, select: 'last'}, (err, counter) ->
    if err
      console.log err
    io.start get_movies, {slience: true}, (err) ->
      if err
        console.log err
      close_db()

task 'get:movie', "Get movie's info and comments' url", ->
  open_db()
  io.start get_movie, {slience: true}, (err) ->
    if err
      console.log err
    close_db()
