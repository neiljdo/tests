start = Date.now()

foo = ->
  console.log (Date.now() - start)

  (i for i in [0..10000000])

  return

setTimeout foo, 1000

bar = ->
  console.log (Date.now() - start)

setTimeout bar, 2000