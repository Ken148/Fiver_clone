Rails.application.routes.draw do
  get "posts/new"
  devise_for :users
  root 'posts#index' # Assuming posts#index is your main page

  resources :posts, only: [:index, :new, :create, :show, :edit, :update]
end
