class Api::BoardController < ApplicationController

  def valid_moves
     @board = Game.find_game(session[:session_token])
     pos = params['pos']
     moves = Board.get_valid_moves(pos, @board);
     render json: moves
  end

  def play_turn
    @board = Game.find_game(session[:session_token])
    from_pos = params['from_pos'].map{|el| el.to_i}
    to_pos = params['to_pos'].map{|el| el.to_i}
    @board = Board.make_move(from_pos, to_pos, @board)
    ai_move = Board.get_AI_move(@board)
    @board = Board.make_move(ai_move[0], ai_move[1], @board)
    sleep (2)
    render 'board'
  end


end
