(function(root) {
  'use strict';

  root.ApiUtil = {
    newGame: function(){
      $.ajax({
        url: "api/game/new_game",
        type: "GET",
        dataType: "json",
        success: function(response){
          ApiActions.recivedBoard(response);
        }
      })
    },

    validMoves: function(pos, board){
      var params = {
        board: board,
        pos: pos
      }
      $.ajax({
        url: "api/board/valid_moves",
        type: "POST",
        dataType: "json",
        data: params,
        success: function(response){
          ApiActions.recivedValidMoves(response);
        }
      })
    },

    playTurn: function(from_pos, to_pos, board){
      var params = {
        from_pos: from_pos,
        to_pos: to_pos,
        board: board
      }
      $.ajax({
        url: "api/board/play_turn",
        type: "POST",
        dataType: "json",
        data: params,
        success: function(response){
          ApiActions.recivedBoard(response);
        }
      })
    },

    continueGame: function(){
      $.ajax({
        url: "api/game/continue_game",
        type: "GET",
        dataType: "json",
        success: function(response){
          ApiActions.recivedBoard(response);
        }
      })
    }


  }
}(this));
