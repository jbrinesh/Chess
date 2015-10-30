(function(root) {
  'use strict';

  root.BoardActions = {
    selectPosition: function(position){
      var action = {
        actionType: Constants.POSITION_SELECTED,
        position: position
      }
      AppDispatcher.dispatch(action);
    },

    makeMove: function(position){
      var action ={
        actionType: Constants.MAKE_MOVE,
        position: position
      }
      AppDispatcher.dispatch(action);
    }

  }
}(this));
