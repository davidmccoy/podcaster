require 'sidekiq/web'

 Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  mount Shrine.uppy_s3_multipart(:cache) => "/s3"

  root 'home#index'

  devise_for :user, path: 'user', controllers: { registrations: 'user/registrations' }

  devise_scope :user do
    # registration paths
    get 'user', to: 'user/registrations#show'
    get 'user/password', to: 'user/registrations#password'
    post 'user/update_password', to: 'user/registrations#update_password'
    namespace 'user' do
      resources :pages, param: :slug, path: 'podcasts'
      get 'upload', to: 'pages#upload'
    end
  end

  resources :users

  get 'podcasts/recover', to: 'pages#recover'
  post 'podcasts/recover', to: 'pages#send_recovery_email'

  resources :imports
  resources :pages, param: :slug, path: 'podcasts' do
    get '/feed', to: 'pages#feed'
    get '/settings', to: 'pages#settings'
    get '/delete', to: 'pages#delete'
    resources :posts, param: :slug do
      resources :audios, path: 'audio' do
        post 'record_play', to: 'audios#record_play'
        get '/link/*url', to: 'audios#link', as: 'link'
      end
    end
    resource :logo
    resources :stats, only: [:index]
    resources :page_categories, as: :categories, path: 'categories'
  end

  resources :episodes, only: [:create]

  resource :support
  resource :faq

  # ***|| routes for old rss feeds ||***
  # in home controller --> '/?feed=podcast'
  get '/feed', to: 'pages#mtgcast'
  get '/topics/mtgcast-podcast-shows/retired-and-archived-podcast-shows/:podcast/feed', to: 'old_feeds#redirect'
  get '/topics/mtgcast-podcast-shows/active-podcast-shows/:podcast/feed', to: 'old_feeds#redirect'
end
