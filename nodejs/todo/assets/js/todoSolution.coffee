Storage::setObj = (key, obj) ->
  localStorage.setItem key, JSON.stringify(obj)

Storage::getObj = (key) ->
  JSON.parse this.getItem(key)

class TodoApp

  constructor: ->
    @cacheElements()
    @bindEvents()
    @displayItems()

  cacheElements: ->
    @$input = $('.new-todo')
    @$todoList = $('.todo-list')
    @$clearCompleted = $('.clear-completed')
    @$joinListName = $(".join-list-name")
    @$join = $('.join')
    @$connect = $('.connect')
    @$disconnect = $('.disconnect')
    @$connectedList = $('.connected-list')
    @$leave = $('.leave')

  bindEvents: ->
    @$input.on 'keyup', (e) => @create e
    @$todoList.on 'click', '.destroy', (e) => @destroy e.target
    @$todoList.on  'change', '.toggle', (e) => @toggle e.target
    @$clearCompleted.on 'click', (e) => @clearCompleted()
    @$join.on 'click', (e) => @joinList()
    @$leave.on 'click', (e) => @leaveList()

  create: (e) ->
    val = $.trim @$input.val()
    return unless e.which == 13 and val

    randomId = Math.floor Math.random()*999999

    newItem =
       id: randomId
       title: val
       completed: false

    localStorage.setObj randomId, newItem
    @socket.emit 'newItem', newItem if @socket
    @$input.val ''
    @displayItems()

  displayItems: ->
    @clearItems()
    @addItem(localStorage.getObj(id)) for id in Object.keys(localStorage)

  clearItems: ->
    @$todoList.empty()

  addItem: (item) ->
    html = """
      <li #{if item.completed then 'class="completed"' else ''} data-id="#{item.id}">
        <div class="view">
          <input class="toggle" type="checkbox" #{if item.completed then 'checked' else ''}>
          <label>#{item.title}</label>
          <button class="destroy"></button>
        </div>
     </li>
    """
    @$todoList.append html

  destroy: (elem) ->
    id = ($(elem).closest 'li').data('id')
    localStorage.removeItem id
    @socket.emit 'removeItem', id if @socket
    @displayItems()

  toggle: (elem) ->
    id = $(elem).closest('li').data('id')
    item = localStorage.getObj(id)
    item.completed = !item.completed
    localStorage.setObj(id, item)

  clearCompleted: ->
    (localStorage.removeItem id for id in Object.keys(localStorage) \
      when (localStorage.getObj id).completed)
    @displayItems()

  joinList: ->
    @socket = io.connect('http://vboxlocalhost:3000')
    @socket.on 'connect', =>
      @currentList = @$joinListName.val()
      @socket.emit 'joinList', @currentList

    @socket.on 'syncItems', (items) => @syncItems(items)

    @socket.on 'itemAdded', (item) =>
      localStorage.setObj item.id, item
      @displayItems()

    @socket.on 'itemRemoved', (id) =>
      localStorage.removeItem id
      @displayItems()

  syncItems: (items) ->
    console.log 'syncing items'
    localStorage.clear()
    localStorage.setObj item.id, item for item in items
    @displayItems()
    @displayConnected(@currentList)

  displayConnected: (listName) ->
    @$disconnect.removeClass 'hidden'
    @$connectedList.text listName
    @$connect.addClass 'hidden'

  leaveList: ->
    @socket.disconnect() if @socket
    @displayDisconnected()

  displayDisconnected: () ->
    @$disconnect.addClass 'hidden'
    @$connect.removeClass 'hidden'

$ ->
  app = new TodoApp()