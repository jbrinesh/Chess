class Board < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :game_id, null: false
      t.integer :row_pos, null: false
      t.integer :col_pos, null: false
      t.string  :kind, null: false
      t.string  :color, null: false
    end
    add_index :boards, :game_id
  end

end
