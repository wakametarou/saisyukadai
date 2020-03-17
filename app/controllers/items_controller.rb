class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
    @item.item_images.new
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    if @item.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :detail, :condition, :delivery_tax_payer, :delivery_from, :delivery_days, :category, :brand, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
