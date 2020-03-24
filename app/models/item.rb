class Item < ApplicationRecord
  has_many :item_images, dependent: :destroy
  has_one :dealing
  belongs_to :user
  # belongs_to :item_category

  accepts_nested_attributes_for :item_images, allow_destroy: true
  has_many :item_images, dependent: :destroy


  validates :item_images, presence: {message: "を選択してください"}
   

  validates :name, presence: true, length: { maximum: 40 }

  validates :detail, presence: true,length: { maximum: 1000 }

  validates  :category_id, :condition, :delivery_tax_payer, :delivery_from, :delivery_days, presence: {message: "を選択してください"}
 
  validates :price, presence: true,numericality: { only_integer: true,greater_than: 299, less_than: 10000000}
end

class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
