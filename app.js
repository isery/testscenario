
/**
 * Module dependencies.
 */

var server = require('./server'),
    http = require('http');

module.exports = httpServer = http.createServer(server).listen(server.get('port'), function(){
  console.log("Express server listening on port " + server.get('port'));
});