mongo = require \mongoose

# ANSI Terminal Colors.
bold  = '\33[0;1m'
red   = '\33[0;31m'
green = '\33[0;32m'
reset = '\33[0m'

# Db
exports.open-db = ->
  mongo.connect 'mongodb://douban:douban@localhost/douban_movie_top250'

exports.close-db = ->
  mongo.connection.close()

# Color
exports.tint = tint = (text, color = green) ->
  color + text + reset

# Error
# @param {Object} callback (optional): can have 'error' or 'success' callbac
exports.handle-err = (err, callback) ->
  if err
    console.log tint err, red
    callback?.error?!
  else
    callback?.success?!
