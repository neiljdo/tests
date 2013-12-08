c = ->
  b()

b = ->
  a()

a = ->
  throw new Error 'Error yay!'

c()