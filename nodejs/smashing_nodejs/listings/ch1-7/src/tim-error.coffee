c = ->
  b()

b = ->
  a()

a = ->
  setTimeout ->
    throw new Error 'Error yay!'
  , 10

  return

process.on 'uncaughtException', (err) ->
  console.error err
  process.exit 1


c()