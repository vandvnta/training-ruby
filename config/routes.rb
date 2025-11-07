Rails.application.routes.draw do
    namespace :admin do
        get "dashboard", to: "dashboard#index"
        resources :roles
        resources :users
        resources :teams

        get "login", to: "sessions#new", as: :login
        post "login", to: "sessions#create"
        delete "logout", to: "sessions#destroy", as: :logout
    end
    root "admin/dashboard#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
