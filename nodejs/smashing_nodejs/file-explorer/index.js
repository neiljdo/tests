var fs = require('fs'),
    stdin = process.stdin,
    stdout = process.stdout
    dir = process.cwd() + '/' + (process.argv[2] || '');


// generic handling of errors
process.on('uncaughtException', function(err) {
  console.log('An error occured!')
  console.log(err);
  process.exit(1);
});

fs.readdir(dir, function(err, files) {
  var stats = [];

  if (!files.length) {
    return console.log('    \033[31m No files to show!\033[39m\n');
  }

  console.log('    Select which file or directory you want to see\n');

  function file(i) {
    var filename = files[i];

    fs.stat(dir + '/' + filename, function(err, stat) {
      stats[i] = stat;

      if (stat.isDirectory()) {
        console.log('    ' + i + '    \033[36m' + filename + '/\033[39m');
      } else {
        console.log('    ' + i + '    \033[90m' + filename + '\033[39m');
      }

      if (++i == files.length) {
        read();
      } else {
        file(i);
      }
    });
  }

  function read() {
    console.log('');
    stdout.write('    \033[33mEnter your choice: \033[39m');
    stdin.resume();
    stdin.setEncoding('utf8');

    stdin.on('data', option);
  }

  function option(data) {
    var filename = files[Number(data)];

    if (!filename) {
      stdout.write('    \033[31mEnter your choice: \033[39m');
    } else {
      stdin.pause();

      if (stats[Number(data)].isDirectory()) {
        fs.readdir(dir + '/' + filename, function(err, files) {
          console.log('');
          console.log('    (' + files.length + ' files)');
          files.forEach(function(file) {
            console.log('    -  ' + file);
          });
          console.log('');
        });
      } else {
        fs.readFile(dir + '/' + filename, 'utf8', function(err, data) {
          console.log('');
          console.log('\033[90m' + data.replace(/(.*)/g, '    $1') + '\033[39m');
        });
      }
    }
  }

  file(0);
});
