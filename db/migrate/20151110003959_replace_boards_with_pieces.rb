class ReplaceBoardsWithPieces < ActiveRecord::Migration
  def change
    rename_table :boards, :pieces 
  end
end
