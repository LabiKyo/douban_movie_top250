require! {
  io: \node.io
  mongo: \mongoose
  async

  \./option
  \./helper .handle-err
}

methods =
  input: (start, num, callback) ->
    require! \./model .Movie

    async.map [i for i from start til start+num],
      (id, callback) ->
        # find movie, id start from 1
        err, movie <- Movie.find-by-id id+1, douban-id: true
        callback err, movie

      , (err, movies) ->
        handle-err err,
          success: ->
            callback movies
          error: ->
            callback null

  run: (movies) ->
    if typeof! movies isnt \Array
      movies = [movies]
    movies = async.map movies,
      (movie, callback) ~>
        url = "http://movie.douban.com/subject/#{movie.douban-id}/"
        err, $, data <~ @getHtml url
        movie.review-count = $('.related_info h2 span.pl')[*-1].children[1].children[1].children[0].data
        callback err, movie

      , (err, movies) ~>
        handle-err err,
          success: ~>
            @emit movies

  output: (movies) ->
    console.log \out movies
    require! \./model .Movie
    movies.for-each (movie) ->
      err <- Movie.find-by-id-and-update movie._id, {review-count: movie.review-count}, {}
      handle-err err

exports.job = new io.Job option, methods
