class Item < ApplicationRecord
  has_many :item_images, dependent: :destroy
  has_one :dealing
  belongs_to :user
  belongs_to :item_category
  belongs_to :item_brand, optional: true

  accepts_nested_attributes_for :item_images, allow_destroy: true

end
