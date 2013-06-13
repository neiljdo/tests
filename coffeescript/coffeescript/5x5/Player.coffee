tileValues =
  A: 1, B: 3, C: 3, D: 2, E: 1, F: 4, G: 2, H: 4, I: 1, J: 8, K: 5, L: 1,
  M: 3, N: 1, O: 1, P: 3, Q: 10, R: 1, S: 1, T: 1, U: 1, V: 4, W: 4, X: 8,
  Y: 4, Z: 10

class Player
  constructor: (@name, dictionary) ->
    @setDictionary dictionary if dictionary?

  setDictionary: (@dictionary) ->
    @score = 0
    @moveCount = 0

  makeMove: (swapCoords) ->
    @dictionary.grid.swap swapCoords
    @moveCount++

    result = @scoreMove @dictionary.grid, swapCoords
    @score += result.moveScore

    result

  scoreMove: (grid, swapCoordinates)->
    {x1, y1, x2, y2} = swapCoordinates
    words = @dictionary.wordsThroughTile(x1, y1).concat @dictionary.wordsThroughTile(x2, y2)

    moveScore = multiplier = 0
    newWords = []
    for word in words when word not in @dictionary.usedWords and @dictionary.isNewWord word
      multiplier++
      moveScore += tileValues[letter] for letter in word
      newWords.push word
    @dictionary.usedWords = @dictionary.usedWords.concat newWords
    moveScore *= multiplier

    {moveScore, newWords}


# make Player global
root = exports ? window
root.Player = Player

