Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :posts
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :posts
      # resources :users
      post '/login', to: 'auth#create'
      post '/sign_up', to: 'users#create'
      get '/current_user', to: 'auth#show'
      get '/users', to: 'users#index'
      get '/user/:id', to: 'users#profile'
      post 'user/:id', to: 'users#update'
    end
  end
end
