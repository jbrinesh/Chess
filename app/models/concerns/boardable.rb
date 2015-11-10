module Boardable
  extend ActiveSupport::Concern

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

  def pieces
    pieces = []
    @grid.flatten.each do |space|
      pieces << space unless space.nil?
    end
    return pieces
  end

end
