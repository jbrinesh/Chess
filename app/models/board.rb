class Board
  include Boardable
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

  def get_AI_move
    black_pieces = self.pieces.select {|piece| piece.color == "black"}
    valid_moves = []
    black_pieces.each do |piece|
      piece_moves = self.get_valid_moves(piece.pos)
      piece_moves.each do |to_pos|
        move = [piece.pos, to_pos]
        valid_moves << move
      end
    end
    valid_moves.shuffle.first
  end

  def get_valid_moves(pos)
    piece = self[pos]
    color = piece.color
    potential_moves = piece.potential_moves
    valid_moves = []
    potential_moves.each do |to_pos|
      if self.valid_move?(pos, to_pos, color)
        valid_moves << to_pos
      end
    end
    valid_moves
  end

  def all_black_moves
    all_moves = []
    self.pieces.each do |piece|
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
    king_pos = self.pieces.find do |piece|
      piece.is_a?(King) && piece.color == color
    end.pos
    op_pieces = self.pieces.select { |piece| piece.color != color }
    op_pieces.any? { |piece| piece.potential_moves.include?(king_pos) }
  end

  def stalemate?
    white_king = self.pieces.find do |piece|
      piece.is_a?(King) && piece.color == "white"
    end
    black_king = self.pieces.find do |piece|
      piece.is_a?(King) && piece.color == "black"
    end
    white_pieces = self.pieces.select { |piece| piece.color == "white" }
    black_pieces = self.pieces.select { |piece| piece.color == "black" }

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
end
