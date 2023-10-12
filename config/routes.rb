require "sidekiq/web"

Rails.application.routes.draw do
  get "users/register", as: :users_register
  post "users/setup"

  resources :rooms, only: [:create, :show]
  post "rooms/:id/leave", to: "rooms#leave", as: :room_presence_leave

  get "home/index"
  root "home#index"

  mount Sidekiq::Web, at: "sidekiq"
end
