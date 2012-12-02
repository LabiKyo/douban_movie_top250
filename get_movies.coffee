io = require 'node.io'

options = require './options'

# base url
url = 'http://movie.douban.com/top250'
input = []
for i in [0..9]
  input.push "#{url}?start=#{25 * i}"

methods =
  input: input
  output: 'links.txt'
  run: (url) ->
    @getHtml url, (err, $, data) ->
      if err
        @exit err

      output = []
      $('.hd a').each (container) ->
        output.push container.attribs.href

      @emit output

exports.job = new io.Job options, methods
