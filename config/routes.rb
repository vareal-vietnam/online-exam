Rails.application.routes.draw do
  root "tests#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/add_question/:id", to: "tests#add_question", as: "add_question"
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users
  resources :tests, only: [:new, :create]
end
