# require "byebug"
# require_relative 'rook'
# require_relative 'bishop'

module Pieceable
  extend ActiveSupport::Concern

  include Slidable

  class Piece

    def present?
      true
    end

    def space
      " "
    end

    def potential_moves
      output =[]
      self.all_moves.each do |move|
        output << move if potential_move?(move)
      end
      output
    end

    def potential_move?(to_pos)
      return false unless board[to_pos].nil? || self.color != board[to_pos].color
      self.path(to_pos).each do |sub_pos|
        unless board[sub_pos].nil?
          return false
        end
      end
      true
    end

    def path(to_pos)
      row_max = [pos[0],to_pos[0]].max
      row_min = [pos[0],to_pos[0]].min
      col_max = [pos[1],to_pos[1]].max
      col_min = [pos[1],to_pos[1]].min
      if pos[0] == to_pos[0]
        line = all_horizontal
        line.reject do |sub_pos|
          sub_pos[1] >= col_max ||
          sub_pos[1] <= col_min ||
          sub_pos[0] > row_max ||
          sub_pos[0] < row_min
        end
      elsif pos[1] == to_pos[1]
        line = all_horizontal
        line.reject do |sub_pos|
          sub_pos[1] > col_max ||
          sub_pos[1] < col_min ||
          sub_pos[0] >= row_max ||
          sub_pos[0] <= row_min
        end
      else
        line = all_diagonal
        line.reject do |sub_pos|
          sub_pos[1] >= col_max ||
          sub_pos[1] <= col_min ||
          sub_pos[0] >= row_max ||
          sub_pos[0] <= row_min
        end
      end
    end


    def dup(temp_board)
      new_pos =  self.pos.dup
      new_color = self.color
      new_class = self.class
      new_class.new(new_color, new_pos, temp_board)
    end

    def on_board?(position)
      position.all? { |el| (0..7).include?(el) }
    end
  end
end
