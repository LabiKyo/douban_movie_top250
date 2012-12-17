require! {
  io: \node.io
  mongo: \mongoose

  \./option
  \./helper .handle-err
}

input = ["http://movie.douban.com/top250?start=#{25 * i}" for i from 0 to 9]
regex = /^http:\/\/movie.douban.com\/subject\/(\d+)\/$/

methods =
  input: input
  run: (url) ->
    err, $, data <~ @getHtml url
    handle-err err, error: ~> @exit err

    output = []
    $ '.hd a' .each (container) ->
      output.push container.attribs.href
    @emit output
  output: (urls) ->
    require! \./model .Movie
    require! \./model .Counter
    url <- urls.for-each
    err, counter <- Counter.get-and-increase 'movie'
    handle-err err
    err, movie <- Movie.find-by-id-and-update counter.last, {douban-id: regex.exec url .1}, {upsert: true}
    handle-err err

exports.job = new io.Job option, methods
