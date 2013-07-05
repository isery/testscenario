
/**
 * Module dependencies.
 */

var express = require('express'),
    routes = require('./routes'),
    user = require('./routes/user'),
    path = require('path');

var app  = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'ejs');
  app.use(express.favicon());
  //app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express['static'](path.join(__dirname, 'public')));
});

app.configure('development', function(){
  app.use(express.errorHandler());
});


switch(process.env.NODE_ENV) {
  case 'test': 
    break;
  case 'development':
    break;
  case 'production':
    break;
  default:
    break;
}

app.get('/', routes.index);
app.get('/users', user.list);
app.post('/users', user.list);
app.get('*', function(req, res){
  res.send('what???', 404);
});
module.exports = app;
