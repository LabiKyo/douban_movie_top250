io = require 'node.io'
_ = require 'underscore'

options = require './options'

methods =
  #input: 'links.txt'
  output: 'data.json'
  run: (url) ->
    @getHtml url, (err, $, data) ->
      if err
        console.log err
        @exit err
      ratings = {}
      _($('.rating_wrap').children)
        .filter (node) =>
          node.type is 'text'
        .map (node, index) =>
          ratings[5 - index] = @filter(node.data).trim()

      output =
        title: $('h1 span').first().text
        link: url
        votes: $('.rating_self a span').text
        average: $('.rating_num').text
        ratings: ratings
      @emit output

exports.job = new io.Job options, methods
