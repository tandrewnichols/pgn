var _ = require('lodash');
exports.Fingerprinter = require('./fingerprint');

exports.parse = function(pgn) {
  if (!pgn) return {};
  
  try {
    var parts = pgn.split('\n\n');
    var game = {
      raw: pgn,
      meta: this.parseMetaData(parts[0])
    };
    game.result = {
      whiteWins: game.meta.result === '1-0',
      blackWins: game.meta.result === '0-1',
      draw: game.meta.result === '1/2-1/2'
    };

    game.moves = this.parseMoves(parts[1].replace(game.meta.result, ''));
    return game;
  } catch (e) {
    return {
      error: e
    };
  }
};

exports.parseMetaData = function(top) {
  return _.reduce(top.split('\n'), function(memo, line) {
    var name = line.match(/^\[([a-zA-Z]+)\s/)[1];
    var val = line.match(/"([^"]+?)"/)[1];
    memo[ _.camelCase(name) ] = val;
    return memo;
  }, {});
};

exports.parseMoves = function(bottom) {
  var self = this;
  return _.reduce(bottom.split(/\s(?=\d{1,3}\.)/), function(memo, move) {
    var commentColor, comment = '';
    if (move.indexOf('{') > -1) {
      comment = move.match(/\{([^}]+?)\}/)[1];
      commentColor = /\d{1,3}\.[^\s]+?\s\{/.test(move.trim()) ? 'w' : 'b';
      move = move.replace('{' + comment + '}', '');
    } else if (move.indexOf(';') > -1) {
      comment = move.split(';')[1];
      commentColor = 'a';
    }

    var parts = move.trim().split(/\.|\s(?!\{)/);
    var num = Number(parts[0]);
    var white = parts[1];
    var black = parts[2];
    comment = comment ? comment.replace(/\n/g, '').trim() : '';

    var whiteMove = self.buildMove(num, true, white);
    whiteMove.comment = (comment && ['a', 'w'].indexOf(commentColor) > -1) ? comment : '';
    memo.push(whiteMove);

    if (black) {
      var blackMove = self.buildMove(num, false, black);
      blackMove.comment = (comment && ['a', 'b'].indexOf(commentColor) > -1) ? comment : '';
      memo.push(blackMove);
    }

    return memo;
  }, []);
};

exports.buildMove = function(num, white, move) {
  return {
    number: num,
    ply: num * 2 - (white ? 1 : 0),
    color: white ? 'white' : 'black',
    piece: /^[RNBQK]/.test(move) ? move.charAt(0) : '',
    notation: move,
    check: _.contains(move, '+'),
    mate: _.contains(move, '#'),
    capture: _.contains(move, 'x'),
    castle: _.contains(move, 'O'),
    side: move === 'O-O' ? 'K' : (move === 'O-O-O' ? 'Q' : ''),
    promotion: _.contains(move, '='),
    to: move.split('=')[1],
    mistake: _.contains(move, '?') && !_.contains(move, '??') && !_.contains('!'),
    blunder: _.contains(move, '??'),
    dubious: _.contains(move, '?!'),
    interesting: _.contains(move, '!?'),
    good: _.contains(move, '!') && !_.contains(move, '!!') && !_.contains('?'),
    brilliant: _.contains(move, '!!')
  };
};
