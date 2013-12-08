class Person
  constructor: (@name) ->

  talk: ->
    console.log "my name is #{@name}"

module.exports = Person