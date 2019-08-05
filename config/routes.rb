Rails.application.routes.draw do
  root "tests#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/edit_profile", to: "users#edit_profile"
  get "/tests/:id/results", to: "tests#result_user", as: "result_user"
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users
  resources :tests
  resources :questions, only: [:destroy, :edit, :update]
  resources :account_activations, only: [:edit]
end
