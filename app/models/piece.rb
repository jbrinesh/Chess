
class Piece < ActiveRecord::Base
  validates :game_id, :row_pos, :col_pos, :kind, :color, presence: true

  belongs_to :game

  def self.createPieces(pieces, game)
    new_pieces = []
    pieces.each do |piece|
      new_piece = Piece.new(
        game_id: game.id,
        row_pos: piece[:position][0],
        col_pos: piece[:position][1],
        color: piece[:color],
        kind: piece[:kind]
      )
      new_piece.save!
      new_pieces << new_piece
    end
    return new_pieces
  end

  def self.make_move(from_pos, to_pos, pieces)
    moving_piece = pieces.find do |piece|
      if piece.row_pos == from_pos[0] && piece.col_pos == from_pos[1]
         true
      else
        false
      end
    end
    taken_piece = pieces.find do |piece|
      if piece.row_pos == to_pos[0] && piece.col_pos == to_pos[1]
         true
      else
        false
      end
    end
    moving_piece.row_pos = to_pos[0]
    moving_piece.col_pos = to_pos[1]
    Piece.update(moving_piece.id, :row_pos => moving_piece.row_pos, :col_pos => moving_piece.col_pos)
    unless taken_piece.nil?
      Piece.delete(taken_piece.id)
      pieces.delete(taken_piece)
    end
    return pieces
  end
end
