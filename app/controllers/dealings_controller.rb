class DealingsController < ApplicationController

  require 'payjp'

  def new
    @address = Address.find_by(user_id: current_user.id)
    @item = Item.find(params[:item_id])
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
    @item = Item.find(params[:item_id])
  end

  def pay
    @item = Item.find(params[:item_id])
    @dealing = Dealing.create(phase: "true", item_id: params[:item_id], user_id: current_user.id)
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
  )
  redirect_to action: 'done' #完了画面に移動
  end
end
