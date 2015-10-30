# require_relative "piece"

module Bishopable
  extend ActiveSupport::Concern

  class Bishop < Pieceable::Piece
    include Slidable
    attr_accessor :pos, :board
    attr_reader :color

    def initialize(color, pos, board)
      @color = color
      @pos = pos
      @board = board
    end

    def all_moves
      all_diagonal
    end
  end
end
