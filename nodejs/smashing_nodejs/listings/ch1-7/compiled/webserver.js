// Generated by IcedCoffeeScript 1.6.3-f
(function() {
  var http;



  http = require('http');

  http.createServer(function(req, res) {
    res.writeHead(200, {
      'Content-Type': 'text/html'
    });
    res.write('Hello ');
    setTimeout(function() {
      res.end('<b>world!</b>');
    }, 3000);
  }).listen(3000);

}).call(this);