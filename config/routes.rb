Rails.application.routes.draw do

  get 'users/new'

  get 'users/create'

  get 'users/show'

  root to: "toppages#index"
  
  get "signup", to: "users#new"
  resources :users, only: [:show, :new, :create]
end
