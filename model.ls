mongo = require \mongoose
{Schema} = mongo

# Counter
CounterSchema = new Schema do
  _id:
    type: String
    unique: true
  last:
    type: Number
    default: 0

CounterSchema.statics.get-and-increase = (name, callback) ->
  @find-by-id-and-update name, {$inc: {last: 1}}, callback

exports.Counter = Counter = mongo.model 'counter', CounterSchema

# Movie
MovieSchema = new Schema do
  * _id:
      type: Number
      unique: true
    douban-id:
      type: Number
      unique: true
    review-count: Number
    reviews: [ReviewSchema]
  * id: false

exports.Movie = Movie = mongo.model 'movie', MovieSchema

# Review
ReviewSchema = new Schema do
  * _id: Number
    author: String
    rating: Number

exports.Review = Review = mongo.model 'review', ReviewSchema
