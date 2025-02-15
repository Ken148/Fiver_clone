Rails.application.routes.draw do
  get "sellers/info"
  get "posts/new"
  get 'become_a_seller', to: 'sellers#info'
  get 'new_seller_profile', to: 'sellers#new'
  post 'create_seller_profile', to: 'sellers#create'

  resources :sellers, only: [:new, :create] do
    member do
      get :occupation_step
      post :occupation_step
      get :security_step
      post :security_step
      get :create_gig_step
      post :create_gig_step
    end
  end

  # Only one devise_for :users block
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'home#index'  # Assuming home#index is your main page

  resources :posts, only: [:index, :new, :create, :show, :edit, :update]
end
