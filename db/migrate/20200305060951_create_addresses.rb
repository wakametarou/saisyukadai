class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :sendfirst_name, null: false
      t.string :sendlast_name, null: false
      t.string :sendfirst_name_kana, null: false
      t.string :sendlast_name_kana, null: false
      t.integer :postal_code, null: false
      t.string :prefecture, null: false
      t.string :city, null: false
      t.string :address_number, null: false
      t.string :building
      t.integer :tell
      t.references :user, foreign_key: true
      t.timestamps
    end
    add_index :addresses, :tell, unique: true
  end
end
