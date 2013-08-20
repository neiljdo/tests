http = require('http');
serv = http.createServer (req, res) ->
  res.writeHead 200, {'Content-Type': 'text/html'}
  res.end '<marquee>Smashing Node!</marquee>'
serv.listen 3000