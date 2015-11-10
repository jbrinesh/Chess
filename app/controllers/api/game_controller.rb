class Api::GameController < ApplicationController

  def new_game
    pieces, game = Game.new_game
    @pieces = Piece.createPieces(pieces, game)
    add_token(game.session_token)
    @messages = []
    render 'api/pieces'
  end

  def continue_game
    session_token = session[:session_token]
    @pieces = Game.find_game(session_token)
    @messages = []
    render 'api/pieces'
  end

end
