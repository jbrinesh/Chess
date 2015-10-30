# require_relative "piece"
# require "byebug"

module Pawnable
  extend ActiveSupport::Concern

  class Pawn < Pieceable::Piece
    attr_accessor :pos, :board
    attr_reader :color

    def initialize(color, pos, board)
      @color = color
      @pos = pos
      @board = board
    end

    def all_moves
      position = pos.dup
      if color == "black"
        combos = [[1,-1],[1,0],[1,1]]
        add = 2
      else
        combos = [[-1,1],[-1,0],[-1,-1]]
        add = -2
      end
      combos.map! do |combo|
         combo = [position[0] + combo[0], position[1] + combo[1]]
      end
      if (color == "black" && pos[0] == 1) || (color == "white" && pos[0] == 6)
        combos << [position[0] + add, position[1]]
      end
      combos.select { |combo| on_board?(combo) }
    end

    def potential_move?(to_pos)
      return false unless super
      if pos[1] == to_pos[1]
        return false unless board[to_pos].nil?
      else
        return false if board[to_pos].nil?
      end
      true
    end

    def path(to_pos)
      if (color == "black" && pos[0] == 1 && to_pos[0] == 3)
        return [[pos[0] + 1, pos[1]]]
      elsif (color == "white" && pos[0] == 6 && to_pos[0] == 4)
        return [[pos[0] - 1, pos[1]]]
      else
        return []
      end
    end

    def on_board?(pos)
      pos.all? { |el| (0..7).include?(el) }
    end
  end
end
