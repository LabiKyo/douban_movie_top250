io = require \node.io
mongo = require \mongoose

option = require \./option
{handle-err} = require \./helper

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
    {Movie, Counter} = require \./model
    url <- urls.for-each
    err, counter <- Counter.get-and-increase 'movie'
    handle-err err
    err, movie <- Movie.findByIdAndUpdate counter.last, {douban-id: regex.exec url .1}, {upsert: true}
    handle-err err

exports.job = new io.Job option, methods
