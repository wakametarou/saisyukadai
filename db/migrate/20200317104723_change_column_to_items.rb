class ChangeColumnToItems < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :condition, :string
    change_column :items, :delivery_tax_payer, :string
    change_column :items, :delivery_from, :string
    change_column :items, :delivery_days, :string
    change_column :items, :category_id, :string
    change_column :items, :brand, :string
  end
end
