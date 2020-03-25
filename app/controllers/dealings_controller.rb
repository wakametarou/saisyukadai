class DealingsController < ApplicationController

  require 'payjp'
  before_action :set_item, only: [:new, :done, :pay]

  def new
    @address = Address.find_by(user_id: current_user.id)
    @card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @default_card_information = customer.cards.retrieve(@card.card_id)
    @card_brand = @default_card_information.brand

    case @card_brand
    when "Visa"
      @card_image = "visa.jpg"
    when "JCB"
      @card_image = "jcb.jpg"
    when "MasterCard"
      @card_image = "master-card.jpg"
    when "American Express"
      @card_image = "american_Express.jpg"
    when "Diners Club"
      @card_image = "dinersclub.jpg"
    when "Discover"
      @card_image = "discover.jpg"
    end
  end

  def done
  end

  def pay
    @dealing = Dealing.create(phase: "true", item_id: params[:item_id], user_id: current_user.id)
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: @item.price, 
    customer: card.customer_id, 
    currency: 'jpy', 
  )
  redirect_to action: 'done' 
  end
end

private

def set_item
  @item = Item.find(params[:item_id])
end