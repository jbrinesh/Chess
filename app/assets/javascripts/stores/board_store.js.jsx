(function(root) {
  'use strict';

  var _board = [];

  var resetBoard = function(board){
    _board = board;
  };

  root.BoardStore = $.extend ({}, EventEmitter.prototype, {

    all: function(){
      return _board.slice(0);
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
      }
    })
  })

}(this));
