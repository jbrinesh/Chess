class Api::BoardController < ApplicationController

  def valid_moves
     pieces = Game.find_game(session[:session_token])
     @board = Boardable::Board.new
     @board.add_pieces(pieces)
     pos = params['pos'].map{|el| el.to_i}
     moves = @board.get_valid_moves(pos);
     render json: moves
  end

  def play_turn
    @pieces = Game.find_game(session[:session_token])
    from_pos = params['from_pos'].map{|el| el.to_i}
    to_pos = params['to_pos'].map{|el| el.to_i}

    board = Boardable::Board.new
    board.add_pieces(@pieces)
    board.move(from_pos, to_pos)
    @pieces = Piece.make_move(from_pos, to_pos, @pieces)

    if board.stalemate? && board.check?("black")
      @messages = ["Game Over","The AI is in checkmate, You Won!"]
    elsif board.stalemate?
      @messages = ["Game Over", "The game is a stalemate"]
    else
      ai_move = board.get_move("black")
      board.move(ai_move[0], ai_move[1])
      @pieces = Piece.make_move(ai_move[0], ai_move[1], @pieces)
    end

    if board.check?("white")
      @messages = ["You are in check"]
    elsif board.stalemate? && board.check?("white")
      @messages = ["Game Over", "You are in checkmate"]
    elsif board.stalemate?
      @messages = ["Game Over", "The game is a stalemate"]
    end

    render 'api/pieces'
  end


end
