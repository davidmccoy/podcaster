require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  root 'home#index'

  resources :episodes, only: [:create]
end
