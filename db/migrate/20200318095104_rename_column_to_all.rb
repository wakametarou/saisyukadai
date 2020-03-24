class RenameColumnToAll < ActiveRecord::Migration[5.2]
  def change
    rename_column :profiles, :users_id, :user_id
    rename_column :dealings, :users_id, :user_id
    rename_column :dealings, :items_id, :item_id
  end
end
