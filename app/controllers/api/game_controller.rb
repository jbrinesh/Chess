class Api::GameController < ApplicationController

  def new_game
    result = Game.new_game
    board = result[0]
    game = result[1]
    @board = Board.createBoard(board, game)
    add_token(game.session_token)
    @messages = []
    render 'board'
  end

  def continue_game
    session_token = session[:session_token]
    @board = Game.find_game(session_token)
    @messages = []
    render 'board'
  end

end
