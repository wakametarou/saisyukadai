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
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    set_item
    @card = Card.where(user_id: current_user.id).first

    respond_to do |format|
      format.json
      format.html
    end

  end

  def destroy
    set_item
    if (@item.destroy)
      flash[:notice] = "削除されました"
      redirect_to items_sold_index_path
    else
      flash.now[:alert] = "削除できませんでした"
      render :show
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if (@item.update(item_params))
      redirect_to item_path(params[:id])
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :detail, :condition, :delivery_tax_payer, :delivery_from, :delivery_days, :category_id, :brand, item_images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
