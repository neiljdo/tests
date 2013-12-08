(function (app) {
  'use strict';

  var Workspace = Backbone.Router.extend({
    routes: {
      '(:filter)': 'setFilter'
    },

    setFilter: function (filter) {
      app.TodoFilter = filter;
      app.Todos.trigger('filter');

      console.log(app.TodoFilter);
    }
  });

  app.TodoRouter = new Workspace();
  Backbone.history.start();

} (window.app || {}));