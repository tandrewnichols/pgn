fs = require 'fs'
expect = require('indeed').expect
file = fs.readFileSync "#{__dirname}/fixtures/opera.txt", { encoding: 'utf8' }

describe 'pgn', ->
  Given -> @pgn = require '../lib/pgn'
  Given -> @contents = file
  
  describe '.parse', ->
    context 'header', ->
      When -> @game = @pgn.parse @contents
      Then -> expect(@game.meta).to.deep.equal
        event: 'Paris'
        site: 'Paris'
        date: '1858.??.??'
        eventDate: '?'
        round: '?'
        result: '1-0'
        white: 'Paul Morphy'
        black: 'Duke Karl / Count Isouard'
        eco: 'C41'
        whiteElo: '?'
        blackElo: '?'
        plyCount: '33'

    context 'result', ->
      context 'white wins', ->
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.result).to.deep.equal
          whiteWins: true
          blackWins: false
          draw: false

      context 'black wins', ->
        Given -> @contents = @contents.replace(/1-0/g, '0-1')
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.result).to.deep.equal
          whiteWins: false
          blackWins: true
          draw: false

      context 'draw', ->
        Given -> @contents = @contents.replace(/1-0/g, '1/2-1/2')
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.result).to.deep.equal
          whiteWins: false
          blackWins: false
          draw: true

      context 'in progress, abandoned, or unknown', ->
        Given -> @contents = @contents.replace(/1-0/g, '*')
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.result).to.deep.equal
          whiteWins: false
          blackWins: false
          draw: false

    context 'moves', ->
      Given -> @contents = @contents.split('\n\n')[0]
      context 'pawn move', ->
        Given -> @contents += '\n\n1.e4 e5'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0]).to.deep.equal
          number: 1
          ply: 1
          color: 'white'
          notation: 'e4'
          piece: ''
          check: false
          mate: false
          capture: false
          castle: false
          side: ''
          promotion: false
          to: undefined
          comment: ''
          mistake: false
          blunder: false
          dubious: false
          interesting: false
          good: false
          brilliant: false
        And -> expect(@game.moves[1]).to.deep.equal
          number: 1
          ply: 2
          color: 'black'
          notation: 'e5'
          piece: ''
          check: false
          mate: false
          capture: false
          castle: false
          side: ''
          promotion: false
          to: undefined
          comment: ''
          mistake: false
          blunder: false
          dubious: false
          interesting: false
          good: false
          brilliant: false

      context 'rook move', ->
        Given -> @contents += '\n\n1.Rg3 e5'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].piece).to.equal 'R'

      context 'knight move', ->
        Given -> @contents += '\n\n1.Ng3 e5'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].piece).to.equal 'N'

      context 'bishop move', ->
        Given -> @contents += '\n\n1.Bg3 e5'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].piece).to.equal 'B'
        
      context 'queen move', ->
        Given -> @contents += '\n\n1.Qg3 e5'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].piece).to.equal 'Q'
        
      context 'king move', ->
        Given -> @contents += '\n\n1.Kg3 e5'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].piece).to.equal 'K'

      context 'check', ->
        Given -> @contents += '\n\n1.Qg3+ e5'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].check).to.equal true

      context 'mate', ->
        Given -> @contents += '\n\n1.Qg3#'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].mate).to.equal true

      context 'capture', ->
        Given -> @contents += '\n\n1.Qxg3'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].capture).to.equal true

      context 'castle king side', ->
        Given -> @contents += '\n\n1.O-O'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].castle).to.equal true
        Then -> expect(@game.moves[0].side).to.equal 'K'

      context 'castle queen side', ->
        Given -> @contents += '\n\n1.O-O-O'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].castle).to.equal true
        Then -> expect(@game.moves[0].side).to.equal 'Q'

      context 'promotion', ->
        Given -> @contents += '\n\n1.e8=Q'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].promotion).to.equal true
        Then -> expect(@game.moves[0].to).to.equal 'Q'

      context 'white comment', ->
        Given -> @contents += '\n\n1.e4 {Best by test.} e5'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].comment).to.equal 'Best by test.'

      context 'black comment', ->
        Given -> @contents += '\n\n1.e4 e5 {Best by test.}'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[1].comment).to.equal 'Best by test.'

      context 'move comment', ->
        Given -> @contents += '\n\n1.e4 e5; Best by test.'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[0].comment).to.equal 'Best by test.'
        And -> expect(@game.moves[1].comment).to.equal 'Best by test.'

      context 'mistake', ->
        Given -> @contents += '\n\n1.e4 e5?'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[1].mistake).to.equal true

      context 'blunder', ->
        Given -> @contents += '\n\n1.e4 e5??'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[1].blunder).to.equal true

      context 'dubious', ->
        Given -> @contents += '\n\n1.e4 e5?!'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[1].dubious).to.equal true

      context 'interesting', ->
        Given -> @contents += '\n\n1.e4 e5!?'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[1].interesting).to.equal true

      context 'good', ->
        Given -> @contents += '\n\n1.e4 e5!'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[1].good).to.equal true

      context 'brilliant', ->
        Given -> @contents += '\n\n1.e4 e5!!'
        When -> @game = @pgn.parse @contents
        Then -> expect(@game.moves[1].brilliant).to.equal true

    context 'no pgn', ->
      When -> @game = @pgn.parse()
      Then -> expect(@game).to.deep.equal {}

    context 'parse error', ->
      Given -> @contents = @contents.split('\n\n')[0]
      When -> @game = @pgn.parse @contents
      Then -> expect(@game.error).to.be.a 'TypeError'
      
