require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  root 'home#index'
  devise_for :users

  resources :users

  resources :episodes, only: [:create]
end
