mongo = require \mongoose
{Schema} = mongo

# Counter
counter-schema = Schema do
  _id:
    type: String
    unique: true
  last:
    type: Number
    default: 0

counter-schema.statics.get-and-increase = (name, callback) ->
  @findByIdAndUpdate name, {$inc: {last: 1}}, callback

exports.Counter = Counter = mongo.model 'counter', counter-schema

# Movie
movie-schema = Schema do
  * _id:
      type: Number
      unique: true
    douban-id:
      type: Number
      unique: true
  * id: false

exports.Movie = Movie = mongo.model 'movie', movie-schema
