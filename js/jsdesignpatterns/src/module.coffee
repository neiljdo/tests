module = (->
  privateProperty = 1

  {
    publicProperty: privateProperty
    someFunction: ->
      console.log 'basically does nothing'
      return
  }
)()

console.log module.publicProperty
module.someFunction()


class MyClass
  constructor: (@name) ->
    console.log 'constructing'

  someMethod: ->
    console.log 'someMethod called'

  @someProperty: '@someProperty'
  someProperty: 'someProperty'

  @someOtherMethod: ->
    console.log someProperty

mc1 = new MyClass('mc1')
mc1.someMethod()
console.log mc1.someProperty

mc2 = new MyClass('mc2')
