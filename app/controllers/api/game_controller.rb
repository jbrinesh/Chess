class Api::GameController < ApplicationController

  def new_game
    result = Game.new_game
    board = result[0]
    game = result[1]
    Board.createBoard(board, game)
    add_token(game.session_token)
    render json: board
  end


end
