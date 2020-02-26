Rails.application.routes.draw do
  resources :cards
  devise_for :users, :controllers => { :registrations => 'registrations'}
  resources :items
  resources :categories
  resources :users

  root to: 'welcome#index'

  get 'admin', to: 'admin#index'
  get 'admin/approvals', to: 'admin#approvals'
  get 'admin/returns', to: 'admin#returns'
  post 'admin/approve', to: 'admin#approve'
  post 'admin/reject', to: 'admin#reject'

  get 'cart', to: 'carts#index'
  post 'cart', to: 'carts#add'
  patch 'cart', to: 'carts#update'
  delete 'cart', to: 'carts#destroy'
  get 'cart/edit/:item_id', to: 'carts#edit', :as => :edit_cart

  get 'order/index', to: 'orders#index'
  post 'order/index', to: 'orders#index'
  get 'order/review', to: 'orders#review'
  post 'order/place', to: 'orders#create'
  get 'order/place', to: 'orders#index'
  get 'order/manage/:id', to: 'orders#manage', :as => :order_manage
  post 'order/return', to: 'orders#return'
  get 'wishlist', to: 'wishlists#index'
  get 'wishlist/add', to: 'wishlists#index'
  post 'wishlist/add', to: 'wishlists#add'
  delete 'wishlist', to: 'wishlists#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end