baz = null

do ->
  foo = 10
  bar = 2

  baz = ->
    foo * bar

  return

console.log baz()
console.log 'yey?  '

###* Class Person ###

class Person
  constructor: (@name, @age) ->

  getName: -> @name

  getAge: -> @age

  setName: (@name) ->

  setAge: (@age) ->


### Create instances of Person ###
alice = new Person 'Alice', 93
bill = new Person 'Bill', 30

### Modify the class ###
Person::getGreeting = ->
  'Hi ' + this.getName() + '!'

### Modify a specific instance ###
alice.displayGreeting = ->
  'via displayGreeting: ' + this.getGreeting()

console.log alice.getGreeting()
console.log bill.getGreeting()
console.log alice.displayGreeting()
console.log bill.displayGreeting()
