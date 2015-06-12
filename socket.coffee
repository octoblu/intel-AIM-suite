net = require 'net'
BufferStream = require 'simple-bufferstream'
AimMessage = require './AimMessage'
MESSAGE_GET_AUDIENCE_STATUS = 0
request = new Buffer [0xFA, 0xCE, 0x01, MESSAGE_GET_AUDIENCE_STATUS, 0x00]
stream = new BufferStream request

message = new AimMessage()

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

client.on 'data', (data)->
  message.addData data
