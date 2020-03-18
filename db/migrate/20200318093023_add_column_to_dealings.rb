class AddColumnToDealings < ActiveRecord::Migration[5.2]
  def change
    add_reference :dealings, :items, foreign_key: true
    add_reference :dealings, :users, foreign_key: true
  end
end
