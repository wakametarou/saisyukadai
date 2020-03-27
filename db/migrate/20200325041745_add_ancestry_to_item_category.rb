class AddAncestryToItemCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :category_id
  end
  def down
    remove_index :item_categories, :ancestry
    remove_column :item_categories, :ancestry
  end
end
