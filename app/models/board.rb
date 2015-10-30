

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

  def self.get_AI_move(from_pos, to_pos, board)
    board_grid = BoardGrid.new()
    board_grid.add_pieces(board)
    from_pos = from_pos.map{|el| el.to_i}
    to_pos = to_pos.map{|el| el.to_i}
    piece = board_grid[from_pos]
    if board_grid[to_pos]
      board_grid[to_pos] = nil
    end
    piece.pos = to_pos
    all_moves = board_grid.all_black_moves
    move = all_moves.shuffle.first
    moving_piece = board_grid[move[0]]
    moving_piece.pos = move[1]
    new_board = [];
    board_grid.grid.flatten.each do |piece|
      unless piece.nil?
        el = {
          position: piece.pos,
          color: piece.color,
          kind: piece.class.to_s.split("::")[1].downcase
        }
        new_board << el
      end
    end
    return new_board
  end

end
