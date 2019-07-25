Rails.application.routes.draw do
  root "tests#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/show", to: "tests#show"
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users
  resources :tests, only: [:new, :create, :index, :show]
end
