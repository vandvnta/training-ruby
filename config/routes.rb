Rails.application.routes.draw do
  resources :roles
  resources :users
  resources :teams
  root "users#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
