require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

  root 'home#index'
  devise_for :users, path: 'user', controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'user', to: 'users/registrations#show'
  end

  resources :users
  resources :pages, path: 'podcasts' do
    get '/feed', to: 'pages#feed'
    resources :posts
  end

  resources :episodes, only: [:create]

  #***|| routes for old rss feeds ||***#
  # in home controller --> '/?feed=podcast'
  get '/feed', to: 'pages#mtgcast'
  get '/topics/mtgcast-podcast-shows/retired-and-archived-podcast-shows/:podcast/feed', to: 'old_feeds#redirect'
  get '/topics/mtgcast-podcast-shows/active-podcast-shows/:podcast/feed', to: 'old_feeds#redirect'
end
