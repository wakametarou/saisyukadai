class ChangeColumnToDealings < ActiveRecord::Migration[5.2]
  def change
    change_column :dealings, :phase, :boolean, default: false, null: false
  end
end
