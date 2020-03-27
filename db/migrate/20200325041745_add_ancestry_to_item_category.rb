class AddAncestryToItemCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :category_id
    create_table :item_categories do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_column :item_categories, :ancestry, :string
    add_index :item_categories, :ancestry
  end
  def down
    remove_index :item_categories, :ancestry
    remove_column :item_categories, :ancestry
  end
end
