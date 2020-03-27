class AddItemCategoryToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :item_category, foreign_key: true
  end
end
