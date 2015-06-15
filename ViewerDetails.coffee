class ViewerDetails
  constructor: () ->

  parse: (data) =>
    if data.length < 20
      return

    @id = data.readUInt32BE 0
    @gender = data.readUInt8 4
    @age = data.readUInt8 5
    @viewingTime = data.readUInt32BE 8
    @topLeftX = data.readUInt16BE 12
    @topLeftY = data.readUInt16BE 14
    @faceWidth = data.readUInt16BE 16
    @faceHeight = data.readUInt16BE 18

    return data.slice 20, data.length

module.exports = ViewerDetails
