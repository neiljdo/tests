var net = require('net'),
    count = 0,
    users = {};

// create a server and connect to it
var server = net.createServer(function(conn) {
  var nickname;
  conn.setEncoding('utf8');

  conn.write(
    '\n > welcome to \033[92mnode-chat\033[39m!' +
    '\n > ' + count + ' other people are connected at this time.' +
    '\n > please write your name and press enter: '
  );

  count++;

  conn.on('close', function() {
    count--;

    // remove conn from users
    delete users[nickname];

    for (nick in users) {
      users[nick].write('\033[90m> ' + nickname + ' has left the room\033[39m\n');
    }
  });

  conn.on('data', function(data) {
    data = data.replace('\r\n', '');

    if (!nickname) {
      if (users[data]) {
        conn.write('\033[93m> nickname already in use. try again:\033[39m ');
        return;
      } else {
        nickname = data;
        users[nickname] = conn;

        // send to the rest of the users
        for (nick in users) {
          users[nick].write('\033[90m> ' + nickname + ' joined the room\033[39m\n');
        }
      }
    } else {
      // we already have a usernam - data is a chat message
      for (nick in users) {
        if (nick !== nickname) {
          users[nick].write('\033[96m> ' + nickname + ':\033[39m ' + data + '\n');
        }
      }
    }
  });
});

server.listen(3000, function() {
  console.log('\033[96m server listening on *:3000\033[39m');
});

// server.on('connection', function(conn) {
//   console.log('\033[90m now with ' + (++count) + ' connections!\033[39m');
// });