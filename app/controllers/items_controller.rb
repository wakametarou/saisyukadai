class ItemsController < ApplicationController
  before_action :set_item, except: [:index,:new,:create,:destroy,:get_category_children,:get_category_grandchildren]
  
  def index
    @items = Item.all.includes(:item_images)
  end

  def new
    @item = Item.new
    @item.item_images.new
    @item_category = ItemCategory.where(ancestry: nil)
  end

  def get_category_children
    @category_children = ItemCategory.find("#{params[:parent_name]}").children
  end

  def get_category_grandchildren
    @category_grandchildren = ItemCategory.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    @item_category = ItemCategory.where(ancestry: nil)
    if @item.save!
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    set_item
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
    @item = Item.find(params[:id]);
  end

  def update
  end

  private


  def item_params
    params.require(:item).permit(:name, :price, :detail, :condition, :delivery_tax_payer, :delivery_from, :delivery_days, :brand, :item_category_id, item_images_attributes: [:image, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
