
class Board < ActiveRecord::Base

  include BoardGridable

  validates :game_id, :row_pos, :col_pos, :kind, :color, presence: true

  belongs_to :game

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

  def self.make_move(from_pos, to_pos, board)
    moving_piece = board.find do |piece|
      if piece.row_pos == from_pos[0] && piece.col_pos == from_pos[1]
         true
      else
        false
      end
    end
    taken_piece = board.find do |piece|
      if piece.row_pos == to_pos[0] && piece.col_pos == to_pos[1]
         true
      else
        false
      end
    end
    moving_piece.row_pos = to_pos[0]
    moving_piece.col_pos = to_pos[1]
    Board.update(moving_piece.id, :row_pos => moving_piece.row_pos, :col_pos => moving_piece.col_pos)
    unless taken_piece.nil?
      Board.delete(taken_piece.id)
      board.delete(taken_piece)
    end
    return board
  end

  def self.get_AI_move(board)
    board_grid = BoardGrid.new()
    board_grid.add_pieces(board)
    all_moves = board_grid.all_black_moves
    move = all_moves.shuffle.first
  end

end
