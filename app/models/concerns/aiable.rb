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
      best_move = nil
      max_value = nil
      valid_moves.each do |move|
        temp_board = board.deep_dup
        temp_board.move(move[0], move[1])
        if max_value.nil? || max_value < temp_board.value("black")
          max_value = temp_board.value("black")
          best_move = move
        end
      end
      return best_move
    end

  end
end
