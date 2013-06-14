# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

toggleItem = (elem) ->
    $li = $(elem).closest('li').toggleClass('completed')
    id = $li.data 'id'

    data = "todo_item[completed]=#{elem.checked}"
    url = "/todo_items/#{id}"

    $.ajax
      type: 'PUT'
      url: url
      data: data

destroyItem = (elem) ->
  $li = $(elem).closest('li')
  id = $li.data 'id'

  url = "/todo_items/#{id}"

  $.ajax
    type: 'DELETE'
    url: url
    success: ->
      $li.remove()

clearCompleted = ->
  (destroyItem(item) for item in $('.todo-list .completed'))

$ ->
  $('.todo-list').on 'change', '.toggle', (e) -> toggleItem e.target
  $('.todo-list').on 'click', '.destroy', (e) -> destroyItem e.target
  $('.clear-completed').on 'click', clearCompleted