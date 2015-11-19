module Valueable
  extend ActiveSupport::Concern

  def value(color)
    pieces = self.pieces
    value_hash = {
      "Pawnable::Pawn" => 1,
      "Knightable::Knight" => 3.2,
      "Bishopable::Bishop" => 3.33,
      "Rookable::Rook" => 5.1,
      "Queenable::Queen" => 8.8,
      "Kingable::King" => 0
    }
    player_score = 0
    oppenant_score = 0

    pieces.each do |piece|

      if piece.color == color
        player_score += value_hash[piece.class.to_s]
      else
        oppenant_score += value_hash[piece.class.to_s]
      end
    end
    return player_score - oppenant_score
  end
end
