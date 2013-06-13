console.log "Hello world!"

console.log do -> "Hello functions!"

h1 = -> "Hello functions v2!"
console.log h1()

greeting = (subject) -> "Hello, #{subject}"
console.log greeting 'arguments'

cube = (num) -> Math.pow num, 3
console.log cube 2

odd = (num) ->
  if typeof num is 'number'
    if num is Math.round num
      if num > 0
        num % 2 is 1
      else
        throw "#{num} is not positive"
    else
      throw "#{num} is not an integer"
  else
    throw "#{num} is not a number"

try
  odd 5.1
catch e
  console.log e

$ = (arg) ->
  {
    each: -> true
  }

console.log ($ 'p').each()

try
  odd '5.1'
catch e
  console.log e

try
  odd -3
catch e
  console.log e


x = 1
y = ->
  console.log x

  x = 2
  console.log x

console.log y()
console.log x


# 2.2 Scope Test - coffeescript uses lexical scoping
# age = 99
# reincarnate = -> age = 0
# reincarnate()
# console.log "Age: #{age}"

reincarnate = -> age = 0
age = 99
reincarnate()
console.log "Age: #{age}"

singCountdown = (count) ->
  singBottleCount = (specifyLocation) ->
    locationStr = if specifyLocation then 'on the wall' else ''
    bottleStr = if count is 1 then 'bottle' else 'bottles'
    console.log "#{count} #{bottleStr} of beer #{locationStr}"
  singDecrement = ->
    console.log 'Take one down, pass it around'
    count--
  singBottleCount true
  singBottleCount false
  singDecrement()
  singBottleCount false
  if count isnt 0 then singCountdown count

singCountdown 5


# 2.3 Context Test
setName = (name) ->
  @name = name
  return
cat = {}
cat.setName = setName
cat.setName 'Mingming'
console.log cat.name

pig = {}

setName.apply pig, ['Babs']
console.log pig.name

Dog = setName
d1 = new Dog('D1')
d2 = new Dog('D2')
console.log d1.name
console.log d2.name

setName 'Lulu'    # global context
console.log name
console.log global.name
console.log @name

callback = (message) => @voicemail.push message

console.log 'yey'

setProp = (@prop) ->

console.log [1, 2, 3]..., 4


# 3.2 Arrays
console.log [1..5]
console.log [1...5]
console.log [5..1]
console.log [5...1]

# slicing
a = ['a', 'b', 'c', 'd']
console.log a.slice 0, 3
console.log a[0..3]
console.log a[0...3]
console.log a[3..0]
console.log a[3...0]
console.log a[2..]
console.log a[2...]
console.log a[2..-2]
console.log a[2...-2]
console.log a[2..-4]
console.log a[-3..]

# splicing
arr = ['a', 'c' ,'d']
arr[1...2] = 'b'
console.log arr

# string slicing
console.log 'The year is 3022'[-4..]


# 3.3 Iterating over Collections
object = 
  key: 'value'
  'key2': 'value2'

for key, value of object
  console.log "#{key} #{value}"