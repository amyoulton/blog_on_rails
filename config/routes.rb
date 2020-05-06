Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resource :users, only: [:new, :create, :edit, :destroy]
  
  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  
end
