io = require 'node.io'
get_movies = require('./get_movies').job
get_movie = require('./get_movie').job

task 'get:movies', "Get movies' url", ->
  io.start get_movies, {slience: true}, (err) ->
    if err
      console.log err

task 'get:movie', "Get movie's info and comments' url", ->
  io.start get_movie, {slience: true}, (err) ->
    if err
      console.log err
