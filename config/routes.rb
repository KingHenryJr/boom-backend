Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :users
      resources :sessions

      get '/users/', to: 'users#show'
      patch '/users/', to: 'users#update'
      post '/users/', to: 'users#create'
      post '/sessions/', to: 'sessions#create'

    end
  end
end
