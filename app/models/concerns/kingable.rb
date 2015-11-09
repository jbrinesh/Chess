module Kingable
  extend ActiveSupport::Concern
  class King < Pieceable::Piece
    attr_accessor :pos, :board
    attr_reader :color

    def initialize(color, pos, board)
      @color = color
      @pos = pos
      @board = board
    end

    def all_moves
      combos = []
      [-1,1,0].repeated_permutation(2).each do |combo|
        combos << combo
      end
      combos -= [[0,0]]

      combos.map! do |combo|
         combo = [pos[0] + combo[0], pos[1] + combo[1]]
      end
      combos.select { |combo| on_board?(combo) }
    end

    def path(to_pos)
      []
    end
  end
end
