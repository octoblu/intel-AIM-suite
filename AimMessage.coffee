class AimMessage
  constructor: () ->

  addData: (data) =>
    console.log "got #{data.length} bytes"
    console.log "data #{data.toString('hex')}"

    @magicWord = data.slice 0, 2
    @version = data.slice 2, 3
    @type = data.slice 3, 4
    @payloadSize = data.slice 4, 5

    console.log "MagicWord is: #{@magicWord.toString('hex')}"
    console.log "Version is: #{@version.toString('hex')}"
    console.log "Type is: #{@type.toString('hex')}"
    console.log "payload size is: #{@payloadSize.toString('hex')}"


module.exports = AimMessage
