Rails.application.routes.draw do
  root "tests#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users
  resources :tests, only: [:new, :create, :index, :show, :destroy]
  resources :questions, only: [:destroy]
end
