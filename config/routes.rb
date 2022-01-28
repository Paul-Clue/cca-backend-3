Rails.application.routes.draw do
  resources :milestones
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # resources :posts
  # resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :posts
      # resources :users
      #----------USERS ROUTES----------
      post '/login', to: 'auth#create'
      post '/sign_up', to: 'users#create'
      post '/user/:id', to: 'users#update'
      post '/email_code', to: 'users#code_verify'
      post '/passchangecode', to: 'users#update_password'
      post '/passchangeverify', to: 'users#code_verify_password'

      delete '/deleteuser/:id', to: 'users#destroy'

      get '/email_check', to: 'users#send_mail'
      get '/stattotaltime', to: 'users#total_time_until_employ'
      get '/statalluserslocations', to: 'users#user_locations'
      get '/statallusersemployment', to: 'users#all_user_employment_status'
      get '/profilepic/:id', to: 'users#profile_pic'

      get '/current_user', to: 'auth#show'
      get '/users', to: 'users#index'
      get '/user/:id', to: 'users#profile'



      #----------POST ROUTES----------
      post '/post/:id', to: 'posts#update'
      post '/post', to: 'posts#create'

      delete '/deletepost/:id', to: 'posts#destroy'

      get '/posts', to: 'posts#index'
      get '/post/:user_id', to: 'posts#current_user_posts'
      # get '/user/:id', to: 'users#profile'



      #----------MILESTONE ROUTES----------
      post '/milestone/:id', to: 'milestones#update'
      post '/milestone', to: 'milestones#create'

      delete '/deletemilestone/:id', to: 'milestones#destroy'

      get '/milestones', to: 'milestones#index'
      get '/milestone/:user_id', to: 'milestones#current_user_milestones'

    end
  end
end
