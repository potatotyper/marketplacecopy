Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "/about", to: "about#index"

  get "/sign-up", to: "registrations#new"
  
  post "/sign-up", to: "registrations#create"

  root to: "main#index"

  delete "/logout", to: "sessions#destroy"

  get "/sign-in", to: "sessions#new"

  post "/sign-in", to: "sessions#create"

end
