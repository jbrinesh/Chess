(function(root) {
  'use strict';

  root.ApiUtil = {
    newGame: function(){
      $.ajax({
        url: "api/game",
        type: "GET",
        dataType: "json",
        success: function(response){
          ApiActions.recivedBoard(response);
        }
      })
    },

    validMoves: function(){

    },

    playTurn: function(){

    }
  }
}(this));
