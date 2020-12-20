# typed: strict
Rails.application.routes.draw do
  # Authentication
  post 'signin', to: "auth#signin"
  post 'login', to: "auth#login"
  # User
end
