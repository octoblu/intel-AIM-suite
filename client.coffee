net = require('net')
register = require('coffee-script/register')
client = net.connect({
  host: '192.168.100.66'
  port: 12500
}, ->
  console.log 'connected to server!'
  client.write 'world!\r\n'
  return
)
client.on 'data', (data) ->
  console.log data.toString()
  client.end()
  return
client.on 'end', ->
  console.log 'disconnected from server'
  return
