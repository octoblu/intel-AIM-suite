var net = require('net');
var register = require('coffee-script/register');
var client = net.connect({host: '192.168.100.66', port: 12500}, function() {
  console.log('connected to server!');
  client.write('world!\r\n');
});

client.on('data', function(data) {
  console.log(data.toString());
  client.end();
});

client.on('end', function() {
  console.log('disconnected from server');
});
