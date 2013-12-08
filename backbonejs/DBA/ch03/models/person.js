var Person = (function($) {
  var Person = Backbone.Model.extend({
    defaults: {
      firstName: '',
      lastName: ''
    },
    initialize: function () {
      console.log('this model has been initialized');

      // listen for 'change' event
      this.on('change', function() {
        console.log('model has changed (in general)');
      });

      // listen for 'invalid' event
      this.on('invalid', function(model, error) {
        console.log(model);
        console.log(model.toJSON());
        console.log(error);
      });

      // listen for invalid lastnames -- no such event
      this.on('invalid:lastName', function(model, error) {
        console.log('invalid lastname!');
        console.log(model);
        console.log(model.toJSON());
        console.log(error);
      });
    },
    validate: function (attrs, options) {
      var errors = new Array();

      if (!attrs.firstName || attrs.firstName.length <= 0) {
        errors.push('Invalid first name');
      }

      if (!attrs.lastName || attrs.lastName.length <= 0) {
        errors.push('Invalid last name');
      }

      if (errors.length > 0) {
        return errors;
      }
    }
  });

  return Person;
} (window.jQuery));

window.Person = Person;