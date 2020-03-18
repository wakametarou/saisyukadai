class RenameColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :category, :category_id
  end
end
