Rails.application.routes.draw do
  resources :cards
  devise_for :users, :controllers => { :registrations => 'registrations'}
  resources :items
  resources :categories

  root to: 'welcome#index'
  get 'admin', to: 'admin#index'
  get 'admin/users', to: 'admin#users'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
