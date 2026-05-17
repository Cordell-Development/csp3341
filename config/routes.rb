Rails.application.routes.draw do
  root "saved_locations#index"

  resources :saved_locations, only: [ :create, :destroy, :index ]
  resources :locations, only: [ :index ]

  resource :session
  resources :passwords, param: :token

  namespace :admin do
    resources :users, only: [ :index, :update, :destroy ]
    resources :locations, only: [ :index, :update ]
    resources :api_usages, only: [ :index ]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
