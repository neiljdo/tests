// Generated by IcedCoffeeScript 1.6.3-f
(function() {
  var http, qs, send, stdin, stdout;



  http = require('http');

  qs = require('querystring');

  stdin = process.stdin;

  stdout = process.stdout;

  send = function(theName) {
    var options, req;
    options = {
      host: '127.0.0.1',
      port: 3000,
      url: '/',
      method: 'POST'
    };
    req = http.request(options);
    req.on('response', function(res) {
      console.log("STATUS: " + res.statusCode);
      res.setEncoding('utf8');
      return res.on('end', function() {
        console.log('request complete!');
        return stdout.write('\n your name: ');
      });
    });
    return req.end(qs.stringify({
      name: theName
    }));
  };

  stdout.write('\n your name: ');

  stdin.resume();

  stdin.setEncoding('utf-8');

  stdin.on('data', function(name) {
    name = name.replace('\n', '');
    return send(name);
  });

}).call(this);