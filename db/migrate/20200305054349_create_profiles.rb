class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :first_name_kana, null: false
      t.string :last_name_kana, null: false
      t.text :introduce
      t.string :avatar
      t.date :birthday, null: false
      t.integer :user_id, null: false, foreign_key: true
      t.timestamps
    end


  end
end
