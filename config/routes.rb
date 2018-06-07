Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :users
      resources :sessions

      get '/users/', to: 'users#show'
      post '/sessions/', to: 'sessions#create'
      post '/users/', to: 'users#create'

    end
  end
end
