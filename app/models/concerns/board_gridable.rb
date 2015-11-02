# require_relative 'pieces/pawn'
# require_relative 'pieces/rook'
# require_relative 'pieces/knight'
# require_relative 'pieces/king'
# require_relative 'pieces/queen'
# require_relative 'pieces/bishop'
# require_relative 'pieces/piece'


module BoardGridable
  extend ActiveSupport::Concern

  class BoardGrid
    include Pieceable
    include Pawnable
    include Kingable
    include Queenable
    include Knightable
    include Bishopable
    include Rookable

    attr_accessor :grid
    def initialize()
      @grid = Array.new(8) { Array.new(8) { } }
    end

    def all_black_moves
      all_moves = []
      self.grid.flatten.each do |piece|
        if piece && piece.color == "black"
          piece.potential_moves.each do |to_pos|
            move = [piece.pos, to_pos]
            all_moves << move
           end
        end
      end
      return all_moves
    end

    def add_pieces(board_pieces)
      board_pieces.each do |piece|
        pos = [piece.row_pos, piece.col_pos]
        class_name = piece.kind.capitalize
        module_name = (piece.kind + "able").capitalize
        @grid[pos[0]][pos[1]] = (module_name + "::" + class_name).constantize.new(piece.color, pos, self)
      end
    end

    def valid_move?(first_select, second_select, color)
      unless self[first_select].potential_moves.include?(second_select)
        return false
      end
      return false if check_next_move([first_select,second_select], color)
      true
    end

    def check_next_move(move, color)
      temp_board = self.deep_dup
      temp_board.move(move[0], move[1])
      temp_board.check?(color)
    end

    def check?(color)
      king_pos = self.grid.flatten.find do |piece|
        piece.is_a?(King) && piece.color == color
      end.pos
      op_pieces = self.grid.flatten.select { |piece| piece.color != color }
      op_pieces.any? { |piece| piece.potential_moves.include?(king_pos) }
    end

    def stalemate?
      white_king = self.grid.flatten.find do |piece|
        piece.is_a?(King) && piece.color == "white"
      end
      black_king = self.grid.flatten.find do |piece|
        piece.is_a?(King) && piece.color == "black"
      end
      white_pieces = self.grid.flatten.select { |piece| piece.color == "white" }
      black_pieces = self.grid.flatten.select { |piece| piece.color == "black" }

      return true if white_pieces.none? do |piece|
        piece.potential_moves.any? { |move| valid_move?(piece.pos, move, "white") }
      end

      return true if black_pieces.none? do |piece|
        piece.potential_moves.any? { |move| valid_move?(piece.pos, move, "black") }
      end
      false
    end

    def checkmate?
      return "White" if check?("black") && stalemate?
      return "Black" if check?("white") && stalemate?
    end

    def move(from_pos,to_pos)
      piece = self[from_pos]
      self[to_pos] = piece
      self[from_pos] = nil
      piece.pos = to_pos
    end

    def deep_dup
      temp_board = Board.new
      self.grid.flatten.each do |piece|
        unless piece.is_a?(nil)
          position = piece.pos
          temp_board[position] = piece.dup(temp_board)
        end
      end
      temp_board
    end

    def [](pos)
      row,col = pos
      grid[row][col]
    end

    def []=(pos,mark)
      row,col = pos
      grid[row][col] = mark
    end

    def mark(pos)
      x, y = pos
      @grid[x][y] = Piece.new
    end

    def in_bounds?(pos)
      pos.all? { |x| x.between?(0, 7) }
    end

    def rows
      @grid
    end

  end
end
