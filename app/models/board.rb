

class Board < ActiveRecord::Base
  # include Pieceable
  # include Pawnable
  # include Kingable
  # include Queenable
  # include Knightable
  # include Bishopable
  # include Rookable
  include BoardGridable

  def self.createBoard(board, game)
    board.each do |piece|
      Board.create(
        game_id: game.id,
        row_pos: piece[:position][0],
        col_pos: piece[:position][1],
        color: piece[:color],
        kind: piece[:kind]
      )
    end
  end

  def self.get_valid_moves(pos, board)
    board_grid = BoardGrid.new()
    board_grid.add_pieces(board)
    pos = pos.map{|el| el.to_i}
    piece = board_grid[pos]
    piece.potential_moves
  end

end
