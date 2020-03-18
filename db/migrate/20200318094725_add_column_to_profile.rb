class AddColumnToProfile < ActiveRecord::Migration[5.2]
  def change
    add_reference :profiles, :users, foreign_key: true
  end
end
