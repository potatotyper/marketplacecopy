Rails.application.routes.draw do
  # namespace :api do
  #   namespace :v1 do
  #     resources :users
  #     resources :textposts
  #   end
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root to: "main#home"

  get "/index", to: "main#index"
  
  get "/about", to: "about#index"

  get "/sign-up", to: "registrations#new"
  
  post "/sign-up", to: "registrations#create"

  # delete "/logout", to: "sessions#destroy"

  # get "/sign-in", to: "sessions#new"

  # post "/sign-in", to: "sessions#create"

  get "sign-in", to: "auth#new"

  post "/sign-in", to: "auth#login"

  delete "/logout", to: "auth#logout"

  get "/reset-password", to: "password_reset#new"

  post "/reset-password", to: "password_reset#create"

  get "/reset-password/edit", to: "password_reset#edit"

  patch "/reset-password/edit", to: "password_reset#update"

  get '/auth/google_oauth2/callback', to: "omniauth_callbacks#google"

  get '/posts/new', to: 'textpost#new'

  post '/posts/new', to: 'textpost#create'

  get '/posts/:page', to: 'textpost#view', as: 'view_post'

  get '/post/:id', to: 'textpost#item', as: 'get_post'
  
  delete '/post/:id', to:'textpost#destroy', as: 'del_post'

  get '/posts', to:'textpost#getall', as: 'post_ga'

  resources :rooms do
    resources :messages
  end

  resources :users

end
