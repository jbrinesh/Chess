module Aiable
  extend ActiveSupport::Concern


  def get_move(color)
    valid_moves = self.all_color_moves(color)
    valued_moves = []
    valid_moves.each do |move|
      temp_board = self.deep_dup
      temp_board.move(move[0], move[1])
      value = temp_board.min_max(color, 2, 5)
      valued_moves << [move, value]
    end
    valued_moves.shuffle!.sort! {|a,b| a[1] <=> b[1]}
    valued_moves.last.first
  end

  def min_max(color, depth, breadth)
    color == "black" ? oppoenant_color = "white" : oppoenant_color = "white"
    if depth < 2
      values = []
      oppoenants_moves = self.all_color_moves(oppoenant_color)
      return 100 if oppoenants_moves.empty?
      oppoenants_moves.each do |move|
        temp_board = self.deep_dup
        temp_board.move(move[0], move[1])
        values << temp_board.value(color)
      end
      return values.min
    end

    oppoenants_moves = self.all_color_moves(oppoenant_color)
    scored_oppoenants_moves = score_moves(oppoenants_moves, oppoenant_color)
    scored_oppoenants_moves.shuffle!.sort! {|a,b| a[1] <=> b[1]}
    best_oppoenants_moves = scored_oppoenants_moves.last(breadth)
    min_set = [100]
    best_oppoenants_moves.each do |move|

      temp_board = self.deep_dup
      temp_board.move(move[0][0], move[0][1])
      ai_moves = temp_board.all_color_moves(color)
      scored_ai_moves = score_moves(ai_moves, color)
      scored_ai_moves.shuffle!.sort! {|a,b| a[1] <=> b[1]}
      best_ai_moves = scored_ai_moves.last(breadth)

      max_set = [-100]
      best_ai_moves.each do |ai_move|

        sub_temp_board = temp_board.deep_dup
        sub_temp_board.move(ai_move[0][0], ai_move[0][1])
        max_set << sub_temp_board.min_max(color, depth - 1, breadth)

      end
      min_set << max_set.max
    end
    return min_set.min
  end

  def score_moves(moves, color)
    scored_moves = []
    moves.each do |move|
      temp_board = self.deep_dup
      temp_board.move(move[0], move[1])
      scored_moves << [move, temp_board.value(color)]
    end
    scored_moves
  end


  # def pure_min_max(color, depth)
  #   color == "white" ? oppoenant_color = "black" : oppoenant_color = "white"
  #   if depth < 2
  #     values = []
  #     oppoenants_moves = self.all_color_moves(oppoenant_color)
  #     oppoenants_moves.each do |move|
  #       temp_board = self.deep_dup
  #       temp_board.move(move[0], move[1])
  #       values << temp_board.value(color)
  #     end
  #     return values.min
  #   end
  #
  #   oppoenants_moves = self.all_color_moves(oppoenant_color)
  #   min_set = []
  #   oppoenants_moves.each do |move|
  #     max_set = []
  #     temp_board = self.deep_dup
  #     temp_board.move(move[0], move[1])
  #     ai_player_moves = temp_board.all_color_moves(color)
  #     ai_player_moves.each do |ai_move|
  #       sub_temp_board = temp_board.deep_dup
  #       sub_temp_board.move(ai_move[0], ai_move[1])
  #       max_set << self.min_max(sub_temp_board, color, depth - 1)
  #     end
  #     min_set << max_set.max
  #   end
  #   return min_set.min
  # end

end
