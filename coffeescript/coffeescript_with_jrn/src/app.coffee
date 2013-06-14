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

  bindEvents: ->
    @$input.on 'keyup', (e) => @create(e)
    @$todoList.on 'click', '.destroy', (e) => @destroyItem(e.target)
    @$todoList.on 'change', '.toggle', (e) => @toggleItem(e.target)
    @$clearCompleted.on 'click', => @clearCompleted()

  create: (e) ->
    val = $.trim @$input.val()
    return unless e.which is 13 and val

    randomID = Math.floor (Math.random() * 999999)
    localStorage.setObj randomID, {
      id: randomID,
      title: val,
      completed: false
    }

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

  toggleItem: (elem) ->
    id = $(elem).closest('li').data('id')
    obj = localStorage.getObj(id)
    obj.completed = !obj.completed
    localStorage.setObj(id, obj)
    @displayItems()

  clearCompleted: ->
    (localStorage.removeItem(key) for key in Object.keys(localStorage) when localStorage.getObj(key).completed)
    @displayItems()


$ ->
  app = new TodoApp()