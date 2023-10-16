Rails.application.routes.draw do
resources :articles
# resources :users
resources :comments
post "/login", to: "users#login"
post "/users", to: "users#create"
end
