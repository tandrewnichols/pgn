fs = require 'fs'

describe 'pgn', ->
  Given -> @pgn = require '../lib/pgn'
  
  describe '.parse', ->
    context 'valid pgn', ->
      Given (done) -> fs.readFile "#{__dirname}/fixtures/opera.txt", { encoding: 'utf8' }, (err, @contents) => done()
      When -> @game = @pgn.parse @contents
      Then -> expect(@game).toEqual
        meta:
          event: 'Paris'
          site: 'Paris'
          date: '1858.??.??'
          eventDate: '?'
          round: '?'
          result: '1-0'
          white: 'Paul Morphy'
          black: 'Duke Karl / Count Isouard'
          ECO: 'C41'
          whiteElo: '?'
          blackElo: '?'
          plyCount: '33'
        whiteWins: true
        blackWins: false
        draw: false
        moves: [
          number: 1
          ply: 1
          color: 'white'
          notation: 'e4'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 1
          ply: 2
          color: 'black'
          notation: 'e5'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 2
          ply: 3
          color: 'white'
          notation: 'Nf3'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 2
          ply: 4
          color: 'black'
          notation: 'd6'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 3
          ply: 5
          color: 'white'
          notation: 'd4'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 3
          ply: 6
          color: 'black'
          notation: 'Bg4'
          check: false
          mate: false
          capture: false
          castle: false
          comment: '{This is a week move already.--Fischer}'
        ,
          number: 4
          ply: 7
          color: 'white'
          notation: 'dxe5'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 4
          ply: 8
          color: 'black'
          notation: 'Bxf3'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 5
          ply: 9
          color: 'white'
          notation: 'Qxf3'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 5
          ply: 10
          color: 'black'
          notation: 'dxe5'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 6
          ply: 11
          color: 'white'
          notation: 'Bc4'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 6
          ply: 12
          color: 'black'
          notation: 'Nf6'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 7
          ply: 13
          color: 'white'
          notation: 'Qb3'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 7
          ply: 14
          color: 'black'
          notation: 'Qe7'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 8
          ply: 15
          color: 'white'
          notation: 'Nc3'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 8
          ply: 16
          color: 'black'
          notation: 'c6'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 9
          ply: 17
          color: 'white'
          notation: 'Bg5'
          check: false
          mate: false
          capture: false
          castle: false
          comment: "{Black is in what's like a zugzwang position here. He can't develop the [Queen's] knight because the pawn is hanging, the bishop is blocked because of the Queen.--Fischer"
        ,
          number: 9
          ply: 18
          color: 'black'
          notation: 'b5'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 10
          ply: 19
          color: 'white'
          notation: 'Nxb5'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 10
          ply: 20
          color: 'black'
          notation: 'cbx5'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 11
          ply: 21
          color: 'white'
          notation: 'Bxb5+'
          check: true
          mate: false
          capture: true
          castle: false
        ,
          number: 11
          ply: 22
          color: 'black'
          notation: 'Nbd7'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 12
          ply: 23
          color: 'white'
          notation: 'O-O-O'
          check: false
          mate: false
          capture: false
          castle: true
          side: 'queen'
        ,
          number: 12
          ply: 24
          color: 'black'
          notation: 'Rd8'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 13
          ply: 25
          color: 'white'
          notation: 'Rxd7'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 13
          ply: 26
          color: 'black'
          notation: 'Rxd7'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 14
          ply: 27
          color: 'white'
          notation: 'Rd1'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 14
          ply: 28
          color: 'black'
          notation: 'Qe6'
          check: false
          mate: false
          capture: false
          castle: false
        ,
          number: 15
          ply: 29
          color: 'white'
          notation: 'Bxd7+'
          check: true
          mate: false
          capture: true
          castle: false
        ,
          number: 15
          ply: 30
          color: 'black'
          notation: 'Nxd7'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 16
          ply: 31
          color: 'white'
          notation: 'Qb8+'
          check: true
          mate: false
          capture: false
          castle: false
        ,
          number: 16
          ply: 32
          color: 'black'
          notation: 'Nxb8'
          check: false
          mate: false
          capture: true
          castle: false
        ,
          number: 17
          ply: 33
          color: 'white'
          notation: 'Rd8#'
          check: false
          mate: true
          capture: false
          castle: false
        ]
        raw: "1.e4 e5 2.Nf3 d6 3.d4 Bg4 {This is a weak move already.--Fischer} 4.dxe5 Bxf3 5.Qxf3 dxe5 6.Bc4 Nf6 7.Qb3 Qe7 8.Nc3 c6 9.Bg5 {Black is in what's like a zugzwang position here. He can't develop the [Queen's] knight because the pawn is hanging, the bishop is blocked because of the Queen.--Fischer} b5 10.Nxb5 cxb5 11.Bxb5+ Nbd7 12.O-O-O Rd8 13.Rxd7 Rxd7 14.Rd1 Qe6 15.Bxd7+ Nxd7 16.Qb8+ Nxb8 17.Rd8# 1-0"
