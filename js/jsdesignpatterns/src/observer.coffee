class Observer
  constructor: ->
    @observerList = []

  add: (obj) ->
    @observerList.push obj

  count: ->
    @observerList.length

  empty: ->
    @observerList = []

  get: (ind) ->
    if 0 <= ind < @observerList.length
      @observerList[ind]

  insert: (obj, ind) ->
    @observerList[ind...ind] = obj