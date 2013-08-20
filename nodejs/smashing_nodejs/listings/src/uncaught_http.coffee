http = require 'http'

serv = http.createServer ->
  throw new Error 'This will be uncaught.'

serv.listen 3000

process.on 'uncaughtException', (err) ->
  console.error err
  process.exit 1
  return
