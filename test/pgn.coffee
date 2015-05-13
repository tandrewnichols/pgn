fs = require 'fs'

describe 'pgn', ->
  Given -> @pgn = require '../lib/pgn'
  
  describe '.parse', ->
    context 'valid pgn', ->
      Given (done) -> fs.readFile "#{__dirname}/fixtures/opera.txt", { encoding: 'utf8' }, (err, @contents) => done()
      When -> @game = @pgn.parse @contents
      Then -> expect(@game).toEqual
