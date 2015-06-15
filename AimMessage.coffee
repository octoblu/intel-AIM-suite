ViewerDetails = require './ViewerDetails'

DETAILS_TYPE = 131

class AimMessage
  constructor: () ->
    @details = new ViewerDetails

  parse: (data) =>
    console.log "got #{data.length} bytes"
    console.log "data #{data.toString('hex')}"

    @magicWord = data.slice 0, 2
    @version = data.readUInt8(2)
    @type = data.readUInt8(3)
    @payloadSize = data.readUInt8(4)
    @payload = data.slice 5, data.length

    console.log "MagicWord is: #{@magicWord.toString('hex')}"
    console.log "Version is: #{@version}"
    console.log "Type is: #{@type}"
    console.log "payload size is: #{@payloadSize}"
    console.log "payload: #{@payload.toString('hex')} [len=#{@payload.length}]"

    console.log 'type compared to 0x83 is ', @type == 0x83

    if @type == DETAILS_TYPE
      @getAudienceDetails @payload

  getAudienceDetails: (data) =>
    size = data.readUInt8 0
    console.log 'size byte =', size
    @data = data.slice 1, data.length

    while @data = @details.parse @data
      console.log ' id:', @details.id
      console.log ' gender:', @details.gender
      console.log ' age:', @details.age
      console.log ' viewingTime:', @details.viewingTime
      console.log ' topLeftX:', @details.topLeftX
      console.log ' topLeftY:', @details.topLeftY
      console.log ' faceWidth:', @details.faceWidth
      console.log ' faceHeight:', @details.faceHeight

module.exports = AimMessage
