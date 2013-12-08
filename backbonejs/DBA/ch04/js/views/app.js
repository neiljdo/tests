(function (app, _, $) {
  'use strict';

  var ENTER_KEY = 13;

  app.AppView = Backbone.View.extend({
    el: '#todoapp',

    statsTemplate: _.template($('#stats-template').html()),

    events: {
      'keypress #new-todo': 'createOnEnter',
      'click #clear-completed': 'clearCompleted',
      'click #toggle-all': 'toggleAllComplete'
    },

    initialize: function () {
      this.allCheckbox = this.$('#toggle-all')[0];
      this.$input = this.$('#new-todo');
      this.$footer = this.$('#footer');
      this.$main = this.$('#main');
      this.$todoList = this.$('#todo-list');

      this.listenTo(app.Todos, 'add', this.addOne);
      this.listenTo(app.Todos, 'reset', this.addAll);

      this.listenTo(app.Todos, 'change:completed', this.filterOne);
      this.listenTo(app.Todos, 'filter', this.filterAll);
      this.listenTo(app.Todos, 'all', this.render);           // (re)render the collection during any event

      app.Todos.fetch();            // fetch model info (from the server or from local storage, in our case)
    },

    addOne: function (todo) {
      var view = new app.TodoView({model: todo});
      this.$todoList.append(view.render().el);
    },

    addAll: function () {
      this.$todoList.html('');
      app.Todos.each(this.addOne, this);      // we pass `this` is context here so that `this`
                                              // in our call to addOne still points to app.AppView
    },

    filterOne: function (todo) {
      todo.trigger('visible');
    },

    filterAll: function () {
      app.Todos.each(this.filterOne, this);
    },

    newAttributes: function () {
      return {
        title: this.$input.val().trim(),
        order: app.Todos.nextOrder(),
        completed: false
      };
    },

    createOnEnter: function (event) {
      if (event.which !== ENTER_KEY || !this.$input.val().trim()) {
        return;
      }

      app.Todos.create(this.newAttributes());
      this.$input.val('');
    },

    clearCompleted: function () {
      _.invoke(app.Todos.completed(), 'destroy');
      return false;
    },

    toggleAllComplete: function () {
      var completed = this.allCheckbox.checked;

      app.Todos.each(function (todo) {
        todo.save({
          'completed': completed
        });
      });
    },

    render: function () {
      var completed = app.Todos.completed().length,
          remaining  = app.Todos.remaining().length;

      if (app.Todos.length) {
        // if there are any todos
        this.$main.show();
        this.$footer.show();

        // update footer html with proper completed and remaining count
        this.$footer.html(this.statsTemplate({
          completed: completed,
          remaining: remaining
        }));

        this.$('#filters .btn')
          .removeClass('active')
          .filter('[href="#/' + (app.TodoFilter || '') + '"]')
          .addClass('active');
      } else {
        this.$main.hide();
        this.$footer.hide();
      }

      this.allCheckbox.checked = !remaining;
    }
  });
} (window.app || {}, window._, window.jQuery));