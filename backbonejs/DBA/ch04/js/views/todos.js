(function (app, _, $) {
  'use strict';

  var ENTER_KEY = 13;

  app.TodoView = Backbone.View.extend({
    tagName: 'li',

    template: _.template($('#item-template').html()),

    events: {
      'dblclick label': 'edit',
      'keypress .edit': 'updateOnEnter',
      'blur .edit': 'close',
      'click .toggle': 'toggleCompleted',
      'click .destroy': 'clear'
    },

    initialize: function () {
      this.listenTo(this.model, 'change', this.render);
      this.listenTo(this.model, 'destroy', this.remove);      // remove view when corresponding model gets destroyed
      this.listenTo(this.model, 'visible', this.toggleVisible);
    },

    edit: function () {
      this.$el.addClass('editing');
      this.$input.focus();
    },

    updateOnEnter: function (event) {
      if (event.which === ENTER_KEY) {
        this.close();
      }
    },

    close: function () {
      var val = this.$input.val().trim();

      if (val) {
        this.model.save({title: val});
      }

      this.$el.removeClass('editing');
    },

    toggleVisible: function () {
      this.$el.toggleClass('hidden', this.isHidden());
    },

    isHidden: function () {
      var isCompleted = this.model.get('completed');

      return (
        (!isCompleted && (app.TodoFilter === 'completed')) ||
        (isCompleted && (app.TodoFilter === 'active'))
      )
    },

    toggleCompleted: function () {
      this.model.toggle();
    },

    clear: function () {
      this.model.destroy();
    },

    render: function () {
      this.$el.html(this.template(this.model.toJSON()));

      this.$el.toggleClass('completed', this.model.get('completed'));
      this.toggleVisible();

      this.$input = this.$('.edit');

      return this;
    }
  });
} (window.app || {}, window._, window.jQuery));