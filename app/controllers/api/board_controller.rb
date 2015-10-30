class Api::BoardController < ApplicationController

  def valid_moves
     board = params['board']
     pos = params['pos']
     output = Board.get_valid_moves(pos, board);
     render json: output
  end

  def play_turn
    board = params['board']
    from_pos = params['from_pos']
    to_pos = params['to_pos']
    output = Board.get_AI_move(from_pos, to_pos, board);
    render json: output
  end


end
