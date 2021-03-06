class Dictionary
  constructor: (@originalWordList, grid) ->
    @setGrid grid if grid?

  setGrid: (@grid) ->
    @wordList = @originalWordList.slice 0
    @wordList = (word for word in @wordList when word.length <= @grid.size)

    @minWordLength = Math.min.apply Math, (word.length for word in @wordList)
    @usedWords = []

    for x in [0...@grid.size]
      for y in [0...@grid.size]
        @markUsed word for word in @wordsThroughTile x, y

  markUsed: (word) ->
    if word in @usedWords
      false
    else
      @usedWords.push word
      true

  isWord: (word) -> word in @wordList

  isNewWord: (word) -> word in @wordList and word not in @usedWords

  wordsThroughTile: (x, y) ->
    strings = []
    grid = @grid

    for length in [@minWordLength..@grid.size]
      range = length - 1
      addTiles = (func) ->
        strings.push (func(i) for i in [0..range]).join ''

      for offset in [0...length]
        # Vertical
        if @grid.inRange(x - offset, y) and @grid.inRange(x - offset + range, y)
          addTiles (i) -> grid.tiles[x - offset + i][y]

        # Horizontal
        if @grid.inRange(x, y - offset) and @grid.inRange(x, y - offset + range)
          addTiles (i) -> grid.tiles[x][y - offset + i]

        # Diagonal (upper-left to lower-right)
        if @grid.inRange(x - offset, y - offset) and
           @grid.inRange(x - offset + range, y - offset + range)
          addTiles (i) -> grid.tiles[x - offset + i][y - offset + i]

        # Diagonal (lower-left to upper-right)
        if @grid.inRange(x - offset, y + offset) and
           @grid.inRange(x - offset + range, y + offset - range)
            addTiles (i) -> grid.tiles[x - offset + i][y + offset - i]
      
    str for str in strings when @isWord str


# make Dictionary global
root = exports ? window
root.Dictionary = Dictionary
