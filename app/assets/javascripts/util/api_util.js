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

    continueGame: function(){
      $.ajax({
        url: "api/game",
        type: "PATCH",
        dataType: "json",
        success: function(response){
          ApiActions.recivedBoard(response);
        }
      })
    },

    validMoves: function(pos){
      var params = {
        pos: pos
      }
      $.ajax({
        url: "api/board",
        type: "GET",
        dataType: "json",
        data: params,
        success: function(response){
          ApiActions.recivedValidMoves(response);
        }
      })
    },

    playTurn: function(from_pos, to_pos){
      var params = {
        from_pos: from_pos,
        to_pos: to_pos
      }
      $.ajax({
        url: "api/board",
        type: "PATCH",
        dataType: "json",
        data: params,
        success: function(response){
          ApiActions.recivedBoard(response);
        }
      })
    }
  }
}(this));
