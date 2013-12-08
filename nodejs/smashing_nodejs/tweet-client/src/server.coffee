http = require 'http'
qs = require 'querystring'

server = http.createServer (req, res) ->
    body = ''

    req.on 'data', (chunk) ->
      body += chunk

    req.on 'end', ->
      res.writeHead 200
      setTimeout ->
        res.end 'Done'
        console.log "Got name: #{qs.parse(body).name}"
      , 5000

server.listen 3000