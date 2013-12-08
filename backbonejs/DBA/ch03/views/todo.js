var TodoView = (function($) {
  var TodoView = Backbone.View.extend({
    tagName: 'li',
    todoTpl: _.template('An example template'),

    events: {
      'dblclick label': 'edit',
      'keypress .edit': 'updateOnEnter',
      'blur .edit': 'close'
    },

    render: function () {
      this.$el.html(this.todoTpl(this.model.toJSON()));
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

  return TodoView;
} (window.jQuery));

window.TodoView = TodoView;