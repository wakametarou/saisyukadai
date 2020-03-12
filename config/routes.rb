Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root 'items#index'

  resources :items, only: [:index, :new, :create, :show]

  resources :users, only: :show
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
