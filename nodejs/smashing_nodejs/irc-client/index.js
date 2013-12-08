var net = require('net'),
    client;


client = net.connect(6667, 'irc.freenode.net');
client.setEncoding('utf8');

client.on('connect', function() {
  console.log('client connected');
  client.write('NICK test\r\n');
  client.write('USER test 0 * :realname\r\n');
  client.write('JOIN #node.js\r\n');
});
