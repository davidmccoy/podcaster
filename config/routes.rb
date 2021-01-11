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
    resources :posts, param: :slug, only: [:show] do
      resources :audios, path: 'audio' do
        post 'embedded_play', to: 'audios#embedded_play'
        # get '/link/*url', to: 'audios#link', as: 'link'
      end
    end

    resources :audio_posts, param: :slug, path: "audio-posts", only: [:index]
    resources :text_posts, param: :slug, path: "text-posts"

    namespace 'dashboard' do
      resources :text_posts, param: :slug, path: "posts"
      resources :audio_posts, param: :slug, path: "episodes"
      get 'analytics/audience', to: 'analytics#audience'
      get 'analytics/downloads', to: 'analytics#downloads'
      resource :graphs do
        get 'downloads', to: 'graphs#downloads'
        get 'episodes' , to: 'graphs#episodes'
        get 'devices', to: 'graphs#devices'
        get 'platforms', to: 'graphs#platforms'
        get 'referrers', to: 'graphs#referrers'
        get 'countries', to: 'graphs#countries'
        get 'dummy', to: 'graphs#dummy'
      end
      resource :settings, param: :slug do
        get '/delete', to: 'settings#delete'
      end
      resource :logo
      resources :page_categories, as: :categories, path: 'categories'
    end
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
