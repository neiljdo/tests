http = require 'http'
fs = require 'fs'


server = http.createServer (req, res) ->

  # serve files
  serve = (path, type) ->
    res.writeHead 200, 'Content-Type': type
    fs.createReadStream(path).pipe(res)

  http404 = (msg) ->
    res.writeHead 404
    res.end msg

  if req.method is 'GET' and req.url.substr(0, 7) is '/images' and req.url.substr(-4) is '.jpg'
    filepath = __dirname + '/../../' + req.url
    console.log filepath
    fs.stat filepath, (err, stat) ->
      if err or not stat.isFile()
        http404 'Not Found'
      else
        serve filepath, 'image/jpg'
      return
  else if req.method is 'GET' and req.url is '/'
    console.log 'serving index.html'
    serve __dirname + '/../../index.html', 'text/html'
  else
    http404 'Not Found'
  return

server.listen 3000