module Aiable
  extend ActiveSupport::Concern

  class AIplayer

    def self.get_move(board, color)
      black_pieces = board.pieces.select {|piece| piece.color == color}
      valid_moves = []
      black_pieces.each do |piece|
        piece_moves = board.get_valid_moves(piece.pos)
        piece_moves.each do |to_pos|
          move = [piece.pos, to_pos]
          valid_moves << move
        end
      end
      valid_moves.shuffle.first
    end

  end

end
