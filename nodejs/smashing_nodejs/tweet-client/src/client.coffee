http = require 'http'
qs = require 'querystring'
stdin = process.stdin
stdout = process.stdout

send = (theName) ->
  options =
    host: '127.0.0.1'
    port: 3000
    url: '/'
    method: 'POST'

  req = http.request options

  req.on 'response', (res) ->
    console.log "STATUS: #{res.statusCode}"
    res.setEncoding 'utf8'

    res.on 'end', ->
      console.log 'request complete!'
      stdout.write '\n your name: '

  # send the actual request
  req.end qs.stringify {name: theName}

stdout.write '\n your name: '
stdin.resume()
stdin.setEncoding 'utf-8'
stdin.on 'data', (name) ->
  name = name.replace '\n', ''
  send name