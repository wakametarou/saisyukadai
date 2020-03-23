class ItemsSoldController < ApplicationController
  def index
    @items = Item.all.includes(:item_images);
  end
end
