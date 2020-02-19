Rails.application.routes.draw do
  resources :cards
  devise_for :users, :controllers => { :registrations => 'registrations'}
  resources :items
  resources :categories
  resources :users

  root to: 'welcome#index'
  get 'admin', to: 'admin#index'
  get 'cart', to: 'carts#index'
  post 'cart', to: 'carts#add'
  patch 'cart', to: 'carts#update'
  delete 'cart', to: 'carts#destroy'
  get 'cart/edit/:id', to: 'carts#edit', :as => :edit_cart

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
