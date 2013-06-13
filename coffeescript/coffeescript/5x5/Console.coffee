{Dictionary} = require './Dictionary'
{Grid} = require './Grid'
{Player} = require './Player'
{OWL2} = require './OWL2'


stdin = process.openStdin()
stdin.setEncoding 'utf8'

inputCallback = null
stdin.on 'data', (input) -> inputCallback input

gridSize = 5

setupGame = ->
  console.log 'Enter your name:'

  inputCallback = (input) ->
    grid = new Grid(gridSize)
    dictionary = new Dictionary(OWL2, grid)
    player = new Player(input, dictionary)

    unless dictionary.usedWords.length is 0
      console.log """
        Initially used words:
        #{dictionary.usedWords.join(', ')}
      """

    promptForTile1.call player

promptForTile1 = ->
  console.log "Please enter coordinates for the first tile."
  player = this

  inputCallback = (input)->
    try
      {x, y} = strToCoordinates.call player.dictionary.grid, input
    catch e
      return
    
    promptForTile2.call player, x, y

promptForTile2 = (x1, y1) ->
  console.log 'Please enter coordinates for the second tile.'
  player = this
  
  inputCallback = (input) ->
    try
      {x: x2, y: y2} = strToCoordinates.call player.dictionary.grid, input
    catch e
      return

    if x1 is x2 and y1 is y2
      console.log 'Please choose a different tile.'
    else
      console.log "Swapping (#{x1}, #{y1}) and (#{x2}, #{y2})..."
      x1--; y1--; x2--; y2--;

      {moveScore, newWords} = player.makeMove {x1, y1, x2, y2}

      unless moveScore is 0
        console.log """
          You formed the following word(s):
          #{newWords.join(', ')}
        """

      console.log "Your score after #{player.moveCount} move(s): #{player.score}"

      player.dictionary.grid.printGrid()

      promptForTile1.call player

isInteger = (num) ->
  num is Math.round(num)

strToCoordinates = (input) ->
  halves = input.split ','
  if halves.length is 2
    x = parseFloat halves[0]
    y = parseFloat halves[1]

    if !isInteger(x) or !isInteger(y)
      console.log 'Each coordinate must be an integer.'
    else if not @inRange x - 1, y - 1
      console.log "Each coordinate must be beween 1 and #{@size}."
    else
      {x, y}
  else
    console.log 'Input must be the form of `x,y`.'

console.log "Welcome to #{gridSize}x#{gridSize}!"
setupGame()
