var express = require('express');


var app = express.createServer();
app.set('view engine', 'ejs');
app.set('views', __dirname + '/views');
app.set('view options', {layout: false});


