class RemoveColumnToDealings < ActiveRecord::Migration[5.2]
  def change
    remove_column :dealings, :item_id
    remove_column :dealings, :user_id
  end
end
