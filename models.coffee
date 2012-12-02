mongo = require 'mongoose'

# Movie
movie_schema = mongo.Schema
  _id:
    type: Number
    unique: true
,
  _id: false
  id: false

exports.Movie = Movie = mongo.model 'movie', movie_schema
