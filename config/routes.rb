Rails.application.routes.draw do
  get 'purchase/index'
  get 'purchase/done'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  get 'users/show'
  root 'items#index'
  resources :items, only: [:index, :new, :create, :show] do
    resources :dealings, only: :new
  end

  resources :card, only: [:new, :show] do
    collection do
      post 'show', to: 'card#show'
      post 'pay', to: 'card#pay'
      post 'delete', to: 'card#delete'
    end
  end

  


  resources :purchase, only: [:index] do
    collection do
      get 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end

  resources :users, only: :show
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
