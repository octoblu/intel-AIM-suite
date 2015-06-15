net = require 'net'
BufferStream = require 'simple-bufferstream'
AimMessage = require './AimMessage'
MESSAGE_GET_AUDIENCE_STATUS = 0
MESSAGE_GET_AUDIENCE_DETAILS = 1
MESSAGE_GET_VIEWER_EVENTS = 5
request = new Buffer [
    0xFA, #magic word part 1
    0xCE, #magic word part 2
    0x01, #version
    MESSAGE_GET_VIEWER_EVENTS, #command
    0x01, #payload size
    0x01 #payload

  ]
stream = new BufferStream request

message = new AimMessage()

client = net.connect
  host: '192.168.100.8'
  port: 12500, ->
    #once connected, emits 'connect' event
    #console.log('connected to server')
    console.log client.write(request, (response) ->
      console.log response)

    #stream.pipe(client)

client.on 'connect', ->
  console.log "We're connected!"

client.on 'data', (data)->
  message.parse data
