Rails.application.routes.draw do
  get "posts/new"
  
  # Only one devise_for :users block
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'home#index'  # Assuming home#index is your main page

  resources :posts, only: [:index, :new, :create, :show, :edit, :update]
end
