(function(root) {
  'use strict';

  var _board = [];
  var _selected = null;
  var _valid_moves = [];
  var _thinking = true;

  var resetBoard = function(board){
    _selected = null;
    _valid_moves = [];
    _board = board;
  };

  var toggleThinking = function(){
    _thinking = !_thinking;
  };

  var selectPosition = function(position){
    _selected = position;
  };

  var setValidMoves = function(positions){
    _valid_moves = positions;
  };

  var resetValidMoves = function(){
    _valid_moves = [];
  };

  var makeMove = function(position){
    var board = _board.slice(0);
    var selected = _selected.slice(0)
    ApiUtil.playTurn(selected, position);

    var piece = board.find(function(el){
      if (el.position[0] === selected[0] && el.position[1] === selected[1]){
        return true
      } else {
        return false
      }
    })
    var taken_piece = board.find(function(el){
      if (el.position[0] === position[0] && el.position[1] === position[1]){
        return true
      } else {
        return false
      }
    })
    if (taken_piece){
      var idx = board.indexOf(taken_piece);
      board = board.slice(0, idx).concat(board.slice(idx + 1));
    }
    piece.position = position;
    resetBoard(board);
  };

  root.BoardStore = $.extend ({}, EventEmitter.prototype, {

    board: function(){
      return _board.slice(0);
    },

    selected: function(){
      return _selected;
    },

    validMoves: function(){
      return _valid_moves.slice(0);
    },

    thinking: function(){
      return _thinking;
    },

    addChangeHandler: function(handler){
      BoardStore.on(Constants.BOARD_CHANGED, handler)
    },

    removeChangeHandler: function(){
      BoardStore.removeListener(Constants.BOARD_CHANGED, handler)
    },

    DispatcherID: AppDispatcher.register(function(payload){
      switch (payload.actionType){

        case Constants.RECIVED_BOARD:
        if(payload.messages.indexOf("Game Over") === -1){
          toggleThinking();
        }
        resetBoard(payload.board);
        BoardStore.emit(Constants.BOARD_CHANGED);
        break;

        case Constants.POSITION_SELECTED:
        selectPosition(payload.position);
        resetValidMoves();
        ApiUtil.validMoves(payload.position);
        BoardStore.emit(Constants.BOARD_CHANGED);
        break;

        case Constants.RECIVED_VALID_MOVES:
        setValidMoves(payload.positions);
        BoardStore.emit(Constants.BOARD_CHANGED);
        break;

        case Constants.MAKE_MOVE:
        toggleThinking();
        makeMove(payload.position);
        BoardStore.emit(Constants.BOARD_CHANGED);
        break;


      }
    })
  })

}(this));
