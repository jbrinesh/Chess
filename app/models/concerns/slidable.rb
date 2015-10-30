module Slidable
  extend ActiveSupport::Concern

  def all_horizontal
    output = []
    [0,1].each do |idx|
      (-7..7).each do |mod|
        temp_pos = pos.dup
        temp_pos[idx] += mod
        if on_board?(temp_pos)
          output << temp_pos
        end
      end
    end
    output.uniq - [pos]
  end

  def all_diagonal
    output = []
    [[1,-1],[1,1]].each do |idx|
      (-7..7).each do |mod|
        temp_pos = pos.dup
        temp_pos[0] += idx[0] * mod
        temp_pos[1] += idx[1] * mod
        if on_board?(temp_pos)
          output << temp_pos
        end
      end
    end
    output.uniq - [pos]
  end
end
