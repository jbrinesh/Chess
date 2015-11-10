class Game < ActiveRecord::Base
  validates :session_token, :status, presence: true

  has_many :pieces

  def self.new_game
    session_token = SecureRandom.urlsafe_base64(16)
    game = Game.create( session_token: session_token, status: "active" )
    board = NEW_BOARD
    return [board, game]
  end

  def self.find_game(session_token)
    result = Game.where('games.session_token = ?', session_token).includes(:pieces)
    return result.first.pieces
  end

  NEW_BOARD = [
    {
      position: [0,0],
      kind: "rook",
      color: "black"
    },
    {
      position: [0,1],
      kind: "knight",
      color: "black"
    },
    {
      position: [0,2],
      kind: "bishop",
      color: "black"
    },
    {
      position: [0,3],
      kind: "queen",
      color: "black"
    },
    {
      position: [0,4],
      kind: "king",
      color: "black"
    },
    {
      position: [0,5],
      kind: "bishop",
      color: "black"
    },
    {
      position: [0,6],
      kind: "knight",
      color: "black"
    },
    {
      position: [0,7],
      kind: "rook",
      color: "black"
    },
    {
      position: [7,0],
      kind: "rook",
      color: "white"
    },
    {
      position: [7,1],
      kind: "knight",
      color: "white"
    },
    {
      position: [7,2],
      kind: "bishop",
      color: "white"
    },
    {
      position: [7,3],
      kind: "queen",
      color: "white"
    },
    {
      position: [7,4],
      kind: "king",
      color: "white"
    },
    {
      position: [7,5],
      kind: "bishop",
      color: "white"
    },
    {
      position: [7,6],
      kind: "knight",
      color: "white"
    },
    {
      position: [7,7],
      kind: "rook",
      color: "white"
    },
    {
      position: [1,0],
      kind: "pawn",
      color: "black"
    },
    {
      position: [1,1],
      kind: "pawn",
      color: "black"
    },
    {
      position: [1,2],
      kind: "pawn",
      color: "black"
    },
    {
      position: [1,3],
      kind: "pawn",
      color: "black"
    },
    {
      position: [1,4],
      kind: "pawn",
      color: "black"
    },
    {
      position: [1,5],
      kind: "pawn",
      color: "black"
    },
    {
      position: [1,6],
      kind: "pawn",
      color: "black"
    },
    {
      position: [1,7],
      kind: "pawn",
      color: "black"
    },
    {
      position: [6,0],
      kind: "pawn",
      color: "white"
    },
    {
      position: [6,1],
      kind: "pawn",
      color: "white"
    },
    {
      position: [6,2],
      kind: "pawn",
      color: "white"
    },
    {
      position: [6,3],
      kind: "pawn",
      color: "white"
    },
    {
      position: [6,4],
      kind: "pawn",
      color: "white"
    },
    {
      position: [6,5],
      kind: "pawn",
      color: "white"
    },
    {
      position: [6,6],
      kind: "pawn",
      color: "white"
    },
    {
      position: [6,7],
      kind: "pawn",
      color: "white"
    }
  ]
end
