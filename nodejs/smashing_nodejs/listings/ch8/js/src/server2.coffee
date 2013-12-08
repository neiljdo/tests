connect = require 'connect'


server = connect()
server.use connect.static (__dirname + '/../..')
server.use connect.logger 'dev'

server.listen 3000