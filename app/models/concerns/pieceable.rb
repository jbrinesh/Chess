# require "byebug"
# require_relative 'rook'
# require_relative 'bishop'

module Pieceable
  extend ActiveSupport::Concern

  include Slidable

  class Piece
    attr_reader

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
      # temp_board = board.deep_dup
      # if pos[0] == to_pos[0] || pos[1] == to_pos[1]
      #   temp_board[to_pos] = Rookable::Rook.new("black",to_pos,temp_board)
      #   temp_board[pos] = Rookable::Rook.new("black",pos,temp_board)
      # else
      #   temp_board[to_pos] = Bishopable::Bishop.new("black",to_pos,temp_board)
      #   temp_board[pos] = Bishopable::Bishop.new("black",pos,temp_board)
      # end
      # line = temp_board[pos].all_moves & temp_board[to_pos].all_moves
      # if pos[0] == to_pos[0]
      #   max = [pos[1],to_pos[1]].max
      #   min = [pos[1],to_pos[1]].min
      #   line.reject { |sub_pos| sub_pos[1] > max || sub_pos[1] < min }
      # else
      #   max = [pos[0],to_pos[0]].max
      #   min = [pos[0],to_pos[0]].min
      #   line.reject { |sub_pos| sub_pos[0] > max || sub_pos[0] < min }
      # end

      if pos[0] == to_pos[0] || pos[1] == to_pos[1]
        line = all_horizontal
      else
        line = all_diagonal
      end

      row_max = [pos[0],to_pos[0]].max
      row_min = [pos[0],to_pos[0]].min
      col_max = [pos[1],to_pos[1]].max
      col_min = [pos[1],to_pos[1]].min
      line.reject do |sub_pos|
        sub_pos[1] >= col_max ||
        sub_pos[1] <= col_min ||
        sub_pos[0] >= row_max ||
        sub_pos[0] <= row_min
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
