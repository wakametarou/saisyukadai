class AddAncestryToItemCategory < ActiveRecord::Migration[5.2]
  def change
    remove_reference :item_categories, :item, foreign_key: true

    add_index :item_categories, :ancestry
  end
  def down
    remove_index :item_categories, :ancestry
    remove_column :item_categories, :ancestry
  end
end
