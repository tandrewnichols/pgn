exports.parse = function(pgn) {
  if (!pgn) return {};
  
  var parts = pgn.split('\n\n');
  var game = this.parseMetaData(parts[0]);
};

exports.parseMetaData = function(top) {
  var lines = top.split('\n');
  return lines.reduce(function(memo, lines) {
     
  }, {});
};
