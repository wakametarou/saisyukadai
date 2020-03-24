class RenameColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :category_id, :category_id
  end
end
