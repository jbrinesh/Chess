class Game < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :session_token, null: false
      t.string :status,        null: false
      t.string :name
    end
    add_index :games, :session_token
  end
end
