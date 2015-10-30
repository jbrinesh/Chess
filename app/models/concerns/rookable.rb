# require_relative "piece"

module Rookable
  extend ActiveSupport::Concern

  class Rook < Pieceable::Piece
    include Slidable
    attr_accessor :pos, :board
    attr_reader :color

    def initialize(color, pos, board)
      @color = color
      @pos = pos
      @board = board
    end

    def all_moves
      all_horizontal
    end
  end
end
