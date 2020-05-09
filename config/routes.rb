Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users

  get "/users/:id/password", to: "users#password", as: "user_password"
  post "/update_password", to: "users#update_password"
  
  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  
end
