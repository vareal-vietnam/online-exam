Rails.application.routes.draw do
  root "tests#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users, only: [:new, :create, :edit, :update, :index, :show]
  resources :tests, only: [:index]
end
