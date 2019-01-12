require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  root 'home#index'
  devise_for :users, path: 'user', controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'user', to: 'users/registrations#show'
  end

  resources :users

  resources :episodes, only: [:create]
end
