$(document).ready ->
  console.log 'coffeescript working!'

  $('#flipbook').turn {
    display: 'single'
  }


  $('#flipbook').bind 'start', (event, pageObject, corner) ->
    console.log 'start event'


  $('#flipbook').zoom()