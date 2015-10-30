class Api::BoardController < ApplicationController

  def valid_moves
     board = params['board']
     pos = params['pos']
     output = Board.get_valid_moves(pos, board);
     render json: output 
  end

  def play_turn
    debugger;
  end


end
