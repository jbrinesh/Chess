(function(root) {
  'use strict';

  root.ApiActions = {
    recivedBoard: function(board){
      var action = {
        actionType: Constants.RECIVED_BOARD,
        board: board
      }
      AppDispatcher.dispatch(action);
    }
  }
}(this));
