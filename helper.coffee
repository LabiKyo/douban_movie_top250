mongo = require 'mongoose'

exports.open_db = ->
  mongo.connect 'mongodb://douban:douban@localhost/douban_movie_top250'

exports.close_db = ->
  mongo.connection.close()
