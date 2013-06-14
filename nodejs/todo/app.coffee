express = require 'express'
path = require 'path'

app = express()
server = (require 'http').createServer app
io = (require 'socket.io').listen server

app.set 'views', path.join __dirname, 'views'
app.set 'view engine', 'jade'
app.use express.static(path.join __dirname, 'public')
app.use (require 'connect-assets')()

app.get '/', (req, res) ->
  res.render 'index'

@todos = {}

io.sockets.on 'connection', (socket) =>

  socket.on 'joinList', (list) =>

    socket.list = list
    socket.join list
    @todos[list] ?= []

    socket.emit 'syncItems', @todos[list]

    socket.on 'newItem', (item) =>
      @todos[list].push item
      io.sockets.in(socket.list).emit 'itemAdded', item

    socket.on 'destroyItem', (id) =>
      @todos[list] = (item for item in @todos[list] when item.id isnt id)
      io.sockets.in(socket.list).emit 'itemRemoved', id

    socket.on 'toggleItem', (obj) =>
      # obj here is the toggled version already
      @todos[list] = (item for item in @todos[list] when item.id isnt obj.id)
      @todos[list].push obj

      io.sockets.in(socket.list).emit 'itemToggled', obj

    socket.on 'clearCompleted', =>
      @todos[list] = item for item in @todos[list] when item.completed
      io.sockets.in(socket.list).emit 'clearedCompleted'

server.listen 3000
console.log 'Listening on port 3000'
