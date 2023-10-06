Rails.application.routes.draw do
  get "users/register", as: :users_register
  post "users/setup"
  resources :rooms, only: [:create]
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
