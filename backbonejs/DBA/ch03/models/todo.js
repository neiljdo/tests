var Todo = (function($) {
  var Todo = Backbone.Model.extend({
    defaults: {
      title: '',
      completed: false
    },
    initialize: function () {
      console.log('this model has been initialized');

      // listen for 'change' event
      this.on('change', function() {
        console.log('model has changed (in general)');
      });

      // listen for 'change' event for 'completed' attribute
      this.on('change:completed', function() {
        console.log('model.completed has changed');
      });
    },
    validate: function (attrs, options) {
      if (attrs.title === undefined || attrs.title.length <= 0) {
        return 'Please provide a title for your todo.';
      }
    }
  });

  return Todo;
} (window.jQuery));

window.Todo = Todo;