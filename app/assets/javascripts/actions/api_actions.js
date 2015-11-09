(function(root) {
  'use strict';

  root.ApiActions = {

    recivedBoard: function(response){
      var action = {
        actionType: Constants.RECIVED_BOARD,
        board: response.board,
        messages: response.messages
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
