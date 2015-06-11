net = require 'net'
BufferStream = require 'simple-bufferstream'
###
request[0] = (byte)0xFA; // Magic word (first byte)
   request[1] = (byte)0xCE; // Magic word (second byte)
   request[2] = (byte)0x01; // Version
   request[3] = (byte)MESSAGE_GET_AUDIENCE_STATUS; // Command
   request[4] = (byte)0x00; // Payload size (0 for apiGetAudienceStatus)
###
MESSAGE_GET_AUDIENCE_STATUS = 0
request = new Buffer [0xFA, 0xCE, 0x01, MESSAGE_GET_AUDIENCE_STATUS, 0x00]
stream = new BufferStream request

###
function connected() {
  stream.pipe(client);
  // do other things
}
###

client = net.connect
  host: '192.168.100.66'
  port: 12500, ->
    #once connected, emits 'connect' event
    #console.log('connected to server')
    console.log client.write(request, (response) ->
      console.log response)

    #stream.pipe(client)

client.on 'connect', ->
  console.log "We're connected!"
