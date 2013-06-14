Storage::setObj = (key, val) ->
  @setItem key, JSON.stringify(val)

Storage::getObj = (key) ->
  JSON.parse @getItem(key)

class TodoApp

  constructor: ->
    @cacheElements()
    @bindEvents()
    @displayItems()

  cacheElements: ->
    @$input = $('.new-todo')
    @$todoList = $('.todo-list')
    @$clearCompleted = $('.clear-completed')
    @$joinListName = $('.join-list-name')
    @$join = $('.join')
    @$connect = $('.connect')
    @$disconnect = $('.disconnect')
    @$connectedList = $('.connected-list')
    @$leave = $('.leave')

  bindEvents: ->
    @$input.on 'keyup', (e) => @create(e)
    @$todoList.on 'click', '.destroy', (e) => @destroyItem(e.target)
    @$todoList.on 'change', '.toggle', (e) => @toggleItem(e.target)
    @$clearCompleted.on 'click', (e) => @clearCompleted()
    @$join.on 'click', (e) => @joinList()
    @$leave.on 'click', (e) => @leaveList()

  create: (e) ->
    val = $.trim @$input.val()
    return unless e.which is 13 and val

    randomID = Math.floor (Math.random() * 999999)
    newItem = {
      id: randomID,
      title: val,
      completed: false
    }

    localStorage.setObj randomID, newItem
    @socket.emit 'newItem', newItem if @socket
    @$input.val ''
    @displayItems()

  displayItems: ->
    @clearItems()
    @addItem(localStorage.getObj(key)) for key in Object.keys(localStorage)

  clearItems: ->
    @$todoList.empty()

  addItem: (item) ->
    html = """
      <li data-id="#{item.id}" #{if item.completed then 'class="completed"' else ''}>
        <div class="view">
          <label>
            <input type="checkbox" #{if item.completed then 'checked' else ''} class="toggle"> #{item.title}
          </label>
          <button class="destroy">&times;</button>
        </div>
      </li>
    """

    @$todoList.append html

  destroyItem: (elem) ->
    id = $(elem).closest('li').data('id')
    localStorage.removeItem(id)
    @displayItems()

    @socket.emit 'destroyItem', id if @socket

  toggleItem: (elem) ->
    id = $(elem).closest('li').data('id')
    obj = localStorage.getObj(id)
    obj.completed = !obj.completed
    localStorage.setObj(id, obj)
    @displayItems()

    @socket.emit 'toggleItem', obj if @socket

  clearCompleted: ->
    localStorage.removeItem(key) for key in Object.keys(localStorage) when localStorage.getObj(key).completed
    @displayItems()

    @socket.emit 'clearCompleted' if @socket

  joinList: ->
    @socket = io.connect('http://vboxlocalhost:3000')

    @socket.on 'connect', =>
      @currentList = @$joinListName.val()
      @socket.emit 'joinList', @currentList

    @socket.on 'syncItems', (items) =>
      @syncItems(items)

    @socket.on 'itemAdded', (item) =>
      localStorage.setObj item.id, item
      @displayItems()

    @socket.on 'itemRemoved', (id) =>
      localStorage.removeItem id
      @displayItems()

    @socket.on 'itemToggled', (obj) =>
      localStorage.removeItem(obj.id)
      localStorage.setObj obj.id, obj
      @displayItems()

    @socket.on 'clearedCompleted', =>
      localStorage.removeItem(key) for key in Object.keys(localStorage) when localStorage.getObj(key).completed
      @displayItems()

  leaveList: ->
    @socket.disconnect() if @socket
    @displayDisconnected()

  syncItems: (items) ->
    localStorage.clear()
    localStorage.setObj item.id, item for item in items
    @displayItems()
    @displayConnected(@currentList)

  displayConnected: (listName) ->
    @$disconnect.removeClass 'hidden'
    @$connectedList.text listName
    @$connect.addClass 'hidden'

  displayDisconnected: (listName) ->
    @$connect.removeClass 'hidden'
    @$disconnect.addClass 'hidden'

$ ->
  app = new TodoApp()
