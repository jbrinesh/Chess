(function(root) {
  'use strict';

  var _board = [];
  var _selected = null;
  var _valid_moves = [];

  var resetBoard = function(board){
    _board = board;
  };

  var selectPosition = function(position){
    _selected = position;
  };

  var resetValidMoves = function(positions){
    _valid_moves = positions;
  };

  root.BoardStore = $.extend ({}, EventEmitter.prototype, {

    board: function(){
      return _board.slice(0);
    },

    selected: function(){
      return _selected
    },

    validMoves: function(){
      return _valid_moves.slice(0);
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
        resetBoard(payload.board);
        BoardStore.emit(Constants.BOARD_CHANGED);
        break;

        case Constants.POSITION_SELECTED:
        selectPosition(payload.position);
        resetValidMoves([]);
        ApiUtil.validMoves(payload.position, BoardStore.board());
        BoardStore.emit(Constants.BOARD_CHANGED);
        break;

        case Constants.RECIVED_VALID_MOVES:
        resetValidMoves(payload.positions);
        BoardStore.emit(Constants.BOARD_CHANGED);
        break;
      }
    })
  })

}(this));
