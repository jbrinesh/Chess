module Aiable
  extend ActiveSupport::Concern

  class AIplayer

    def self.get_move(board, color)
      valid_moves = board.all_color_moves(color)
      scored_moves = []
      valid_moves.each do |move|
        temp_board = board.deep_dup
        temp_board.move(move[0], move[1])
        score = self.min_max(temp_board, color, 2)
        scored_moves << [move, score]
      end
      scored_moves.shuffle!
      scored_moves.sort! {|a,b| a[1] <=> b[1]}
      scored_moves.last.first
    end


    def self.min_max(board, color, depth)
      color == "white" ? oppoenant_color = "black" : oppoenant_color = "white"
      if depth < 2
        values = []
        oppoenants_moves = board.all_color_moves(oppoenant_color)
        oppoenants_moves.each do |move|
          temp_board = board.deep_dup
          temp_board.move(move[0], move[1])
          values << temp_board.value(color)
        end
        return values.min
      end

      oppoenants_moves = board.all_color_moves(oppoenant_color)
      min_set = []
      oppoenants_moves.each do |move|
        max_set = []
        temp_board = board.deep_dup
        temp_board.move(move[0], move[1])
        ai_player_moves = temp_board.all_color_moves(color)
        ai_player_moves.each do |ai_move|
          sub_temp_board = temp_board.deep_dup
          sub_temp_board.move(ai_move[0], ai_move[1])
          max_set << self.min_max(sub_temp_board, color, depth - 1)
        end
        min_set << max_set.max
      end
      return min_set.min
    end
  end
end
