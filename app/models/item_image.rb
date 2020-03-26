class ItemImage < ApplicationRecord
  belongs_to :item, optional: true

  mount_uploader :image, ItemImageUploader
  skip_callback :commit, :after, :remove_image!
end
