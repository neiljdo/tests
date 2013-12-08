http = require 'http'

http
  .createServer (req, res) ->
    res.writeHead 200, {'Content-Type': 'text/html'}
    res.write 'Hello '

    setTimeout -> 
      res.end '<b>world!</b>'
      return
    , 3000

    return
  .listen 3000
