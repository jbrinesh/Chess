class Board < ActiveRecord::Base

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
end
