grid = dictionary = currPlayer = player1 = player2 = selectedCoords = null

gridSize = 5

newGame = ->
  grid = new Grid(gridSize)
  dictionary = new Dictionary(OWL2, grid)

  name1 = prompt 'Enter your name:'
  name2 = prompt 'Enter the name of your opponent'
  currPlayer = player1 = new Player(name1, dictionary)
  player2 = new Player(name2, dictionary)

  drawGrid()

  player1.num = 1
  player2.num = 2
  for p in [player1, player2]
    $(".p#{p.num}name").html p.name
    $(".p#{p.num}score").html p.score

drawGrid = ->
  gridHTML = ''
  for x in [0...grid.tiles.length]
    gridHTML += '<ul>'
    for y in [0...grid.tiles.length]
      gridHTML += "<li id='tile#{x}_#{y}'>#{grid.tiles[x][y]}</li>"
    gridHTML += '</ul>'

  $('.grid').html gridHTML

tileClick = ->
  $tile = $(this)

  if $tile.hasClass 'selected'
    selectedCoords = null
    $tile.removeClass 'selected'
  else
    $tile.addClass 'selected'
    [x, y] = @id.match(/(\d+)_(\d+)/)[1..]
    selectTile x, y

selectTile = (x, y) ->
  if selectedCoords is null
    selectedCoords = {x1: x, y1: y}
  else
    selectedCoords.x2 = x
    selectedCoords.y2 = y
    $('.grid li').removeClass 'selected'
    doMove()

doMove = ->
  {moveScore, newWords} = currPlayer.makeMove selectedCoords

  if moveScore is 0
    $notice = $(
      """
      <p class="notice">#{currPlayer.name} formed no words this turn.</p>
      """
    )
  else
    $notice = $(
      """
      <p class="notice">
        #{currPlayer.name} formed the following #{newWords.length} words this turn: <br>
        <strong>#{newWords.join ', '}</strong><br>
        earning #{moveScore} points!
      </p>
      """
    )

  showThenFade $notice
  endTurn()

endTurn = ->
  drawGrid()

  currPlayer = if currPlayer is player1 then player2 else player1
  console.log currPlayer.name

  updateScoreTable()
  selectedCoords = null

showThenFade = ($elem) ->
  $elem.insertAfter $('.grid')
  animationTarget = opacity: 0, height: 0, padding: 0
  $elem.delay(5000).animate animationTarget, 500, -> $elem.remove()

updateScoreTable = ->
  for p in [player1, player2]
    $(".p#{p.num}score").html p.score


$(document).ready ->
  newGame()

  $(document).on 'click', '.grid li', tileClick
