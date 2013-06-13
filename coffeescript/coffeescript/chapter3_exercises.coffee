# Exercise 3.3
# for x in [1, 2]
#   setTimeout (-> console.log x), 50

# for x in [1, 2]
#   do (x) ->
#     setTimeout (-> console.log x), 50


# Exercise 3.4
objContains = (obj, val) ->
  for key, value of obj
    if value is val
      return true
  false

obj = 'key': 'value'
console.log(objContains obj, 'value')
console.log(objContains obj, 'val')


# Exercise 3.5
doAndRepeatUntil = (bodyFunc, conditionFunc) ->
  bodyFunc.call this
  bodyFunc.call this until conditionFunc()

x = 10
bf = ->
  console.log x
  x--
cf = ->
  x is 0
doAndRepeatUntil bf, cf