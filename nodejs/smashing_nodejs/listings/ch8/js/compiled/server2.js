// Generated by IcedCoffeeScript 1.6.3-f
(function() {
  var connect, server;



  connect = require('connect');

  server = connect();

  server.use(connect["static"](__dirname + '/../..'));

  server.use(connect.logger('dev'));

  server.listen(3000);

}).call(this);
