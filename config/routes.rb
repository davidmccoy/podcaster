Rails.application.routes.draw do
  resources :episodes, only: [:create]
end
