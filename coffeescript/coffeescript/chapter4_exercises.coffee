# Exercise 4.1
root = global ? window
root.aphorism = 'Fool me 8 or more times, shame on me'

do restoreOldAphorism = ->
  root.aphorism = 'Fool me once, shame on you'
  console.log aphorism
console.log aphorism


# Exercise 4.2
Genie = ->
  @wishesLeft = Genie.wishesLeft

Genie.wishesLeft = 3

Genie::grantWish = ->
  if @wishesLeft > 0
    console.log 'Your wish is granted!'
    Genie.wishesLeft--
    @wishesLeft--

g = new Genie()
g.grantWish()
g.grantWish()
g.grantWish()
g.grantWish()
g.grantWish()
g.grantWish()
g.grantWish()

g2 = new Genie()
g2.grantWish()


# Exercise 4.4
(window ? global).property = 'global context'
@property = 'surrounding context'

class Foo
  constructor: -> @property = 'instance context'
  bar: => console.log @property

foo = new Foo
bar = foo.bar
foo.bar()
bar()
bar.call foo
bar.call this