Rails.application.routes.draw do
  root "tests#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/edit_profile", to: "users#edit_profile"
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users
  resources :questions, only: [:destroy, :edit, :update]
  resources :account_activations, only: [:edit]
  resources :tests do
    resources :results, only: [:index]
  end
end
