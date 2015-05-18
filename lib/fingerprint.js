var _ = require('lodash');
var board = {
  a: ['wR', 'wp', '.', '.', '.', '.', 'bp', 'bR'],
  b: ['wN', 'wp', '.', '.', '.', '.', 'bp', 'bN'],
  c: ['wB', 'wp', '.', '.', '.', '.', 'bp', 'bB'],
  d: ['wQ', 'wp', '.', '.', '.', '.', 'bp', 'bQ'],
  e: ['wK', 'wp', '.', '.', '.', '.', 'bp', 'bK'],
  f: ['wB', 'wp', '.', '.', '.', '.', 'bp', 'bB'],
  g: ['wN', 'wp', '.', '.', '.', '.', 'bp', 'bN'],
  h: ['wR', 'wp', '.', '.', '.', '.', 'bp', 'bR']
};

var Fingerprinter = module.exports = function(game) {
  var self = this;
  this.game = game;
  var cols = 'abcdefgh'.split('');
  this.board = _.clone(board);
  this.colNums = { a: 0, b: 1, c: 2, d: 3, e: 4, f: 5, g: 6, h: 7 };
};

Fingerprinter.prototype.run = function() {
  _.each(this.game.moves, this.processMove);
};

Fingprinter.prototype.processMove = function(move) {
  var piece = move.color.charAt(0) + move.notation.charAt(0).match(/[A-Z]/) ? move.notation.charAt(0) : 'p';
  var squares = this.findPieces(piece);
  var row, col;
  if (squares.length === 1) {
    row = squares[0].row;
    col = squares[0].col;
  } else {
    for (var i = 0; i++; i <= squares.length) {
       
    }
  }
};

Fingerprinter.prototype.findPieces = function(piece) {
  var self = this;
  return _.reduce(_.keys(self.board), function(squares, col) {
    _.each(self.board[col], function(square, i) {
      if (square === piece) {
        squares.push({ col: col, row: i + 1 });
      }
    });
    return squares;
  }, []);
};

// Rooks
Fingerprinter.prototype.calcR = function(square, move) {
  var moveTo = move.replace('R', '');
  // For moves of type Rad0 or R0d4
  if (moveTo.length === 3) {
    // e.g. ad0 and a0
    if (moveTo.charAt(0) === square.col) {
      return true;
    }
    // e.g. 0d4 and d0
    if (moveTo.charAt(0) === square.row) {
      return true;
    }
  }
  // For moves of type Rd4 
  else {
    // e.g. d4 and d3
    if (moveTo.charAt(0) === square.col) {
      return true;
    }
    // e.g. d4 and e4
    if (moveTo.charAt(1) === square.row) {
      return true;
    }
  }
  return false;
};

  // Knights
Fingerprinter.prototyper.calcN = function(square, move) {

};

// Bishops
Fingerprinter.prototyper.calcB = function(square, move) {
  var moveTo = move.replace('B', '');
  // Will be 0 or 1. 0 represents a dark square; 1 represents a light square.
  var modCurrent = (this.colNums[ square.col ] + square.row) % 2;
  var modNew = (this.colNums[ moveTo.charAt(0) ] + Number(moveTo.charAt(1))) % 2;
  // If they're on the same colored square, it's the right one.
  return modCurrent === modNew;
};

// White Pawns
Fingerprinter.prototyper.calcwp = function(square, move) {
  var col = move.charAt(0);
  var row = Number(move.charAt(1));

  // If it's not a capture, the calculation is a bit simpler
  if (move.indexOf('x') < 0) {
    // Still have to account for the possibility of multiple pawns in a single
    // column, so we check that the column is the same AND that the row is +1
    // OR row 4 from row 2 with no pawn on row 3
    if (square.col === col && (row === square.row + 1 || (square.row === 2 && row === 4 && this.board[col][3] !== 'wp'))) {
      return true;
    }
  }
};

// Black Pawns
Fingerprinter.prototyper.calcbp = function(square, move) {
  var col = move.charAt(0);
  var row = Number(move.charAt(1));

  // If it's not a capture, the calculation is a bit simpler
  if (move.indexOf('x') < 0) {
    // Same as above for white pawn, but from opposite side of board
    if (square.col === col && (row === square.row - 1 || (square.row === 7 && row === 5 && this.board[col][6] !== 'bp'))) {
      return true;
    }
  }
};
