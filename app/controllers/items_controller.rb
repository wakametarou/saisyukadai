class ItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @item.item_images.new
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  # def pay
  #   @item = Item.find(params[:id])
  #   Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
  #   charge = Payjp::Charge.create(
  #   amount: @item.price,
  #   card: params['payjp-token'],
  #   currency: 'jpy'
  #   )
  # end

  private

  def item_params
    params.require(:item).permit(:name, :price, :detail, :condition, :delivery_tax_payer, :delivery_from, :delivery_days, :category, :brand, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
