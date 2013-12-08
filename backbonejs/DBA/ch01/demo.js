/**
 * TodoModel definition
 */
var TodoModel = Backbone.Model.extend({
  defaults: {
    title: '',
    completed: false
  }
});

/**
 * TodoView definition
 */
var TodoView = Backbone.View.extend({
  tagName: 'li',
  todoTpl: _.template($('#item-template').html()),
  events: {
    'dblclick label': 'edit',
    'keypress .edit': 'updateOnEnter',
    'blur .edit': 'close'
  },
  initialize: function () {
    this.$el = $('#todo');
  },
  render: function () {
    this.$el.html(
      this.todoTpl(this.model.toJSON())
    );
    this.input = this.$('.edit');

    return this;
  },
  edit: function () {

  },
  close: function () {

  },
  updateOnEnter: function (e) {

  }
});


var myTodo = new TodoModel({
  title: 'check attributes property of the logged models in the console'
});

var myView = new TodoView({model: myTodo});
