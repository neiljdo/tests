http = require 'http'
qs = require 'querystring'

server = http.createServer (req, res) ->
  if req.url is '/'
    res.writeHead 200, {'Content-Type': 'text/html'}
    res.end [
      '<form method="post" action="url">',
        '<h1>My Form</h1>',
        '<fieldset>',
          '<label>Personal Information</label>',
          '<p>What is your name?</p>',
          '<input type="text" name="name">',
          '<p><input type="submit" valuen="Submit"></p>',
        '</fieldset>',
      '</form>'
    ].join ''
  else if req.url is '/url' and req.method is 'POST'
    body = ''
    req.on 'data', (chunk) ->
      body += chunk
      return

    req.on 'end', ->
      res.writeHead 200, {'Content-Type': 'text/html'}

      console.log(qs.parse body)
      res.end "<p>Your name is <b>#{qs.parse(body).name}</b>.</p>"
      return
  else
    res.writeHead 404
    res.end 'Not Found'

  return

server.listen 3000

