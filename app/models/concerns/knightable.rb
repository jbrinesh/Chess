module Knightable
  extend ActiveSupport::Concern

  class Knight < Pieceable::Piece
    attr_accessor :pos, :has_moved, :board
    attr_reader :color

    def initialize(color, pos, board)
      @color = color
      @pos = pos
      @board = board
    end

    def all_moves
      combos = []
      [-1,1,2,-2].permutation(2).each do |combo|
        combos << combo unless combo.inject(:+) == 0
      end
      combos.map! do |combo|
         combo = [pos[0] + combo[0], pos[1] + combo[1]]
      end
      combos.select { |position| on_board?(position) }
    end

    def path(to_pos)
      []
    end
  end
end
