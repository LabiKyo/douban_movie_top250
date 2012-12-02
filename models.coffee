mongo = require 'mongoose'
{Schema} = mongo

# Counter
counter_schema = Schema
  _id:
    type: String
    unique: true
  last:
    type: Number
    default: 0

counter_schema.statics.get_and_increase = (name, callback) ->
  @findByIdAndUpdate name, {$inc: {last: 1}}, callback

exports.Counter = Counter = mongo.model 'counter', counter_schema

# Movie
movie_schema = Schema
  _id:
    type: Number
    unique: true
  douban_id:
    type: Number
    unique: true
,
  id: false

exports.Movie = Movie = mongo.model 'movie', movie_schema
