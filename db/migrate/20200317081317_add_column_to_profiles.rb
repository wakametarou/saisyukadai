class AddColumnToProfiles < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :first_name
    remove_column :profiles, :last_name
    remove_column :profiles, :first_name_kana
    remove_column :profiles, :last_name_kana
    remove_column :profiles, :birthday, :date
  end
end
