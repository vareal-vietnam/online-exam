Rails.application.routes.draw do
  root "tests#index"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/questions/:id_question/new", to: "questions#new", as: "new_question"
  post "/questions/create", to: "questions#create"
  get "/questions/add/:id_question", to: "questions#add"
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :users
  resources :tests
  resources :questions, only: [:destroy]
end
