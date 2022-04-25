Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[create]
      resources :sessions, only: %i[create]
      post '/road_trip', to: 'roadtrip#create'
      get '/backgrounds', to: 'backgrounds#index'
      get '/forecast', to: 'forecast#index'
    end
  end
end
