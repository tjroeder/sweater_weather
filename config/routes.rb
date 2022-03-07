Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[create]
      resources :sessions, only: %i[create]
      resources :roadtrip, only: %i[create]
      get '/backgrounds', to: 'backgrounds#index'
      get '/forecast', to: 'forecast#index'
      get '/book-search', to: 'books#book_search'
    end
  end
end
