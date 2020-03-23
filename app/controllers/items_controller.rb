class ItemsController < ApplicationController

  def index
    @items = Item.all.includes(:item_images)
  end

  def new
    @item = Item.new
    @item.item_images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.json
      format.html
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to items_sold_index_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :detail, :condition, :delivery_tax_payer, :delivery_from, :delivery_days, :category, :brand, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
