http = require 'http'
qs = require 'querystring'


search = process.argv.slice(2).join(' ').trim()

if not search.length
  console.log '\nUsage: node tweets <search_term>'

console.log "searching for: #{search}"

# request options
options =
  host: 'api.twitter.com'
  path: '/1.1/search/tweets.json?' + (qs.stringify {q: search})

req = http.request options, (res) ->
  body = ''
  res.setEncoding 'utf8'
  res.on 'data', (chunk) ->
    body += chunk

  res.on 'end', ->
    obj = JSON.parse body
    for tweet in obj.statuses
      do (tweet) ->
        console.log tweet.text
        console.log '--'

