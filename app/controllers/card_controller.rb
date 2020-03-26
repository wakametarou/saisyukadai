class CardController < ApplicationController
  
  require "payjp"

  def new
    @card = Card.where(user_id: current_user.id)
    redirect_to action: "show" if @card.exists?
  end


  def pay 
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      description: '登録テスト', 
      email: current_user.email, 
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) 
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "show"
      else
        redirect_to action: "pay"
      end
    end
  end

  def delete 
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to users_show_path(current_user.id)
  end

  
  
  def show 
    @card = Card.where(user_id: current_user.id).first
    @path = Rails.application.routes.recognize_path(request.referer)
    if @card.blank?
      redirect_to action: "new" 
    else
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
  end
end