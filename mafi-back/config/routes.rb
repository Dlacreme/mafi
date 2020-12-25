# typed: strict
Rails.application.routes.draw do
  # Authentication
  post 'signin', to: "auth#signin"
  post 'login', to: "auth#login"
  # User
  resources :user, only: [:index, :show]
  get 'me', to: 'user#me'
  get 'user/search/:query', to: 'user#search'
  # Account
  resources :account, only: [:index, :show, :create, :update, :destroy]
end
