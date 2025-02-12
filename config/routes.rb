Rails.application.routes.draw do
  devise_for :users
  root 'posts#index' # Assuming posts#index is your main page

  resources :posts, only: [:index, :new, :create, :show]
end
