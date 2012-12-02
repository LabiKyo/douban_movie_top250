io = require 'node.io'
mongo = require 'mongoose'
_ = require 'underscore'

options = require './options'

input = ("http://movie.douban.com/top250?start=#{25 * i}" for i in [0..9])
regex = /^http:\/\/movie.douban.com\/subject\/(\d+)\/$/

methods =
  input: input

  output: (urls) ->
    {Movie, Counter} = require './models'
    _(urls)
      .each (url) ->
        Counter.get_and_increase 'movie', (err, counter) ->
          Movie.findByIdAndUpdate counter.last
          ,
            douban_id: regex.exec(url)[1]
          ,
            upsert: true
          , (err, movie) ->
            err

  run: (url) ->
    @getHtml url, (err, $, data) ->
      if err
        @exit err

      output = []
      $('.hd a').each (container) ->
        output.push container.attribs.href

      @emit output

  complete: (callback) ->
    callback()

exports.job = new io.Job options, methods
