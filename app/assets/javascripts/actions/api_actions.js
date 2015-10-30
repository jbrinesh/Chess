(function(root) {
  'use strict';

  root.ApiActions = {

    recivedBoard: function(board){
      var action = {
        actionType: Constants.RECIVED_BOARD,
        board: board
      }
      AppDispatcher.dispatch(action);
    },

    recivedValidMoves: function(positions){
      var action = {
        actionType: Constants.RECIVED_VALID_MOVES,
        positions: positions
      }
      AppDispatcher.dispatch(action);
    }
  }
}(this));
