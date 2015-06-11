net = require('net')
HOST = '192.168.100.66'
PORT = 12500

socket = net.createConnection(PORT, HOST);

socket.on 'connect', ->
  console.log 'hi'
  console.log "Connected to #{HOST}:#{PORT}"

socket.on 'data', (error, data) ->
  console.log 'DATA: ' + data.toString
  console.log 'Error', error

socket.on 'end', ->
  console.log 'ended'
