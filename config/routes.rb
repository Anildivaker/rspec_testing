Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
resources :articles
# resources :users
resources :comments
post "/login", to: "users#login"
post "/users", to: "users#create"
end
