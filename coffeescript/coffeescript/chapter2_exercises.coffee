# Exercise 2.1
clearArray = (array) ->
  array.splice 0, array.length
  array         # this would return the empty array
  return        # this would return nothing

a = [1, 2, 3, 4]
console.log clearArray(a)


# Exercise 2.2
run = (func, args...) -> func args...

fun = (arg1, arg2) ->
  console.log arg1
  console.log arg2
run fun, 'hey', 'I just met you', 'yeah'


# Exercise 2.6
xInContext = ->
  console.log @x
what = {x: 'quantum entaglement'}
xInContext.call what


# Exercise 2.7
x = true
showAnswer = (x=x) ->
  console.log x
  console.log if x then 'It works!' else 'Nay..'
showAnswer()