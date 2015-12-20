Command = SpheroPwn.Command

describe 'Command', ->
  describe '.checksum', ->
    it 'computes the 2s complement of the sum', ->
      buffer = new Buffer [0x01]
      expect(Command.checksum(buffer, 0, 1)).to.equal 0xFE

    it 'computes the sum of the bytes', ->
      buffer = new Buffer [0x01, 0x02, 0x03, 0x04]
      expect(Command.checksum(buffer, 0, 4)).to.equal 0xF5

    it 'respects the start parameter', ->
      buffer = new Buffer [0x01, 0x02, 0x03, 0x04]
      expect(Command.checksum(buffer, 1, 4)).to.equal 0xF6

    it 'respects the end parameter', ->
      buffer = new Buffer [0x01, 0x02, 0x03, 0x04]
      expect(Command.checksum(buffer, 1, 3)).to.equal 0xFA

    it 'works correctly on the documentation example', ->
      buffer = new Buffer [0xFF, 0xFF, 0x00, 0x01, 0x52, 0x01]
      expect(Command.checksum(buffer, 2, 6)).to.equal 0xAB

  describe 'constructor', ->
    it 'builds a ping command correctly', ->
      command = new Command 0x00, 0x01, 0
      command.setSequence 0x52
      expect(command.buffer.toString('hex')).to.equal 'ffff000152ab'
